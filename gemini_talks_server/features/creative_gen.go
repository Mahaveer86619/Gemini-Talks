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
		Parts: []genai.Part{genai.Text("Your name is Se7eN. You will generate a creative response to the given prompt.")},
	}
	model.ResponseMIMEType = "application/json"
	resp, err := model.GenerateContent(ctx, genai.Text(req.Prompt))
	if err != nil {
		http.Error(w, "Failed to generate content", http.StatusInternalServerError)
		return
	}

	jsonData, err := json.Marshal(resp)
	if err != nil {
		http.Error(w, "Failed to marshal response", http.StatusInternalServerError)
		return
	}
	
	w.Header().Set("Content-Type", "application/json")
	w.Write(jsonData)
}
