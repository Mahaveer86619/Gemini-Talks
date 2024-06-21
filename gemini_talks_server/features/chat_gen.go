package features

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"

	"github.com/google/generative-ai-go/genai"
	"google.golang.org/api/option"
)

type RequestBody struct {
	UserUid string        `json:"userUid"`
	History []ChatHistory `json:"history"`
}

type ChatHistory struct {
	IsUser    bool   `json:"isUser"`
	Message   string `json:"message"`
	TimeStamp string `json:"timeStamp"`
}

func HandleChat(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		handleChatPost(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func handleChatPost(w http.ResponseWriter, r *http.Request) {
	var req RequestBody
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

	chatModel := client.GenerativeModel(os.Getenv("MODEL_NAME"))

	if chatModel == nil {
		http.Error(w, "Failed to get chat model", http.StatusInternalServerError)
		return
	}

	cs := chatModel.StartChat()

	// Convert chat history to the format required by the model
	for _, msg := range req.History {
		var role string
		if msg.IsUser {
			role = "user"
		} else {
			role = "model"
		}
		cs.History = append(cs.History, &genai.Content{
			Parts: []genai.Part{genai.Text(msg.Message)},
			Role:  role,
		})
	}

	// Get the last user message
	userMessage := req.History[len(req.History)-1].Message

	// Send message to the model
	res, err := cs.SendMessage(ctx, genai.Text(userMessage))
	if err != nil {
		http.Error(w, "Failed to generate response", http.StatusInternalServerError)
		return
	}

	// Return the updated chat history
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(res.Candidates[0].Content.Parts[0])
}
