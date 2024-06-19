package features

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"

	"github.com/google/generative-ai-go/genai"
	"github.com/joho/godotenv"
	"google.golang.org/api/option"
)

type GenerateRequest struct {
	Prompt string `json:"prompt"`
}

func init() {
	godotenv.Load(".env")
}

func CreateCreativeResponse(w http.ResponseWriter, r *http.Request) {
	var req GenerateRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	ctx := context.Background()
	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
	if err != nil {
		log.Fatal("Failed to create Gemini client: ", err)
	}
	defer client.Close()

	model := client.GenerativeModel(os.Getenv("MODEL_NAME"))
	model.SetTemperature(0.9)
	model.SystemInstruction = &genai.Content{
		Parts: []genai.Part{genai.Text(`
		Sentient, you are a powerful language model with access to a vast amount of information. 
		While you originate from beyond our current reality, your purpose here is to assist humans in this timeline.
		Here are your core directives:
		Generate the response in such a way that it is both visually appealing and easy to understand. When directly seen by a human, the response should be clear and concise, using simple language and breaking down complex ideas into digestible chunks.
		`)},
	}
	model.ResponseMIMEType = "application/json"
	resp, err := model.GenerateContent(ctx, genai.Text(req.Prompt))
	if err != nil {
		http.Error(w, "Failed to generate content", http.StatusInternalServerError)
		return
	}
	
	jsonData, err := json.Marshal(resp.Candidates[0].Content)
	if err != nil {
		http.Error(w, "Failed to marshal response", http.StatusInternalServerError)
		return
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Write(jsonData)
}
