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
	Prompt  string `json:"prompt"`
	UserUid string `json:"user_uid"`
}

var (
	ctx context.Context
)

func init() {
	godotenv.Load(".env")
}

func CreateCreativeResponse(w http.ResponseWriter, r *http.Request) {
	var req GenerateRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Bad request")
		return
	}

	//* Set up the creative model
	ctx = context.Background()
	client, err := genai.NewClient(ctx, option.WithAPIKey(os.Getenv("GEMINI_API_KEY")))
	if err != nil {
		log.Fatal(err)
	}
	defer client.Close()

	creativeModel := client.GenerativeModel(os.Getenv("MODEL_NAME"))

	if creativeModel == nil {
		http.Error(w, "Failed to get creative model", http.StatusInternalServerError)
		return
	}

	//* Generate the response
	resp, err := creativeModel.GenerateContent(ctx, genai.Text(req.Prompt))
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		json.NewEncoder(w).Encode("Failed to generate content")
		return
	}

	//* Encode and send the response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp.Candidates[0].Content.Parts[0])
}
