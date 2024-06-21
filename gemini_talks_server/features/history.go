package features

import (
	"context"
	"encoding/json"
	"net/http"

	firestore "cloud.google.com/go/firestore"
	"github.com/Mahaveer86619/Gemini-Talks/config"
	"google.golang.org/api/iterator"
)

type ChatMessage struct {
	IsUser    bool   `json:"isUser"`
	Message   string `json:"message"`
	TimeStamp string `json:"timeStamp"`
}

type RequestChatHistory struct {
	UserUid string        `json:"userUid"`
	History []ChatMessage `json:"history"`
}
type RequestCreativeHistory struct {
	Prompt    string `json:"prompt"`
	Response  string `json:"response"`
	Timestamp string `json:"timestamp"`
	UserUid   string `json:"user_uid"`
}

type ChatHistoryObject struct {
	Id          string        `json:"id"`
	Prompt      string        `json:"prompt"`
	ChatHistory []ChatMessage `json:"chatHistory"`
	UserUid     string        `json:"user_uid"`
}

type CreativeHistoryObject struct {
	Id        string `json:"id"`
	Prompt    string `json:"prompt"`
	Response  string `json:"response"`
	Timestamp string `json:"timestamp"`
	UserUid   string `json:"user_uid"`
}

var CHAT_HISTORY_COLLECTION = "chat_history"
var CREATIVE_HISTORY_COLLECTION = "creative_history"

func SaveChatHistory(w http.ResponseWriter, r *http.Request) {
	ctx := context.Background()
	client := config.GetFirestoreClient()

	var req RequestChatHistory

	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Bad request")
		return
	}

	if req.UserUid != "" {
		// Save chat history
		ref := client.Collection(CHAT_HISTORY_COLLECTION).NewDoc()
		chatHistory := ChatHistoryObject{
			Id:          ref.ID,
			Prompt:      req.History[0].Message,
			ChatHistory: req.History,
			UserUid:     req.UserUid,
		}

		_, err := ref.Set(ctx, chatHistory, firestore.MergeAll)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			json.NewEncoder(w).Encode("Server error")
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusCreated)
		json.NewEncoder(w).Encode(chatHistory)
		return
	}

	w.WriteHeader(http.StatusBadRequest)
	json.NewEncoder(w).Encode("Invalid history object")
}

func SaveCreativeHistory(w http.ResponseWriter, r *http.Request) {
	ctx := context.Background()
	client := config.GetFirestoreClient()

	var creativeHistory RequestCreativeHistory

	if err := json.NewDecoder(r.Body).Decode(&creativeHistory); err != nil {
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Bad request")
		return
	}

	if creativeHistory.UserUid != "" {
		// Save creative history
		ref := client.Collection(CREATIVE_HISTORY_COLLECTION).NewDoc()
		creativeHistory := CreativeHistoryObject{
			Id:        ref.ID,
			Prompt:    creativeHistory.Prompt,
			Response:  creativeHistory.Response,
			Timestamp: creativeHistory.Timestamp,
			UserUid:   creativeHistory.UserUid,
		}

		_, err := ref.Set(ctx, creativeHistory, firestore.MergeAll)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			json.NewEncoder(w).Encode("Server error")
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusCreated)
		json.NewEncoder(w).Encode(creativeHistory)
		return
	}

	w.WriteHeader(http.StatusBadRequest)
	json.NewEncoder(w).Encode("Invalid history object")
}

func GetHistory(w http.ResponseWriter, r *http.Request) {
	ctx := context.Background()
	client := config.GetFirestoreClient()

	UserUid := r.URL.Query().Get("user_uid")
	historyType := r.URL.Query().Get("type")

	var historyObjects interface{}

	switch historyType {
	case "chat":
		query := client.Collection(CHAT_HISTORY_COLLECTION).Where("UserUid", "==", UserUid).Documents(ctx)
		var chatHistoryObjects []ChatHistoryObject
		for {
			doc, err := query.Next()
			if err == iterator.Done {
				break
			}
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				json.NewEncoder(w).Encode("Failed to get chat history")
				return
			}
			var chatHistoryObject ChatHistoryObject
			doc.DataTo(&chatHistoryObject)
			chatHistoryObjects = append(chatHistoryObjects, chatHistoryObject)
		}
		historyObjects = chatHistoryObjects

	case "creative":
		query := client.Collection(CREATIVE_HISTORY_COLLECTION).Where("UserUid", "==", UserUid).Documents(ctx)
		var creativeHistoryObjects []CreativeHistoryObject
		for {
			doc, err := query.Next()
			if err == iterator.Done {
				break
			}
			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				json.NewEncoder(w).Encode("Failed to get creative history")
				return
			}
			var creativeHistoryObject CreativeHistoryObject
			doc.DataTo(&creativeHistoryObject)
			creativeHistoryObjects = append(creativeHistoryObjects, creativeHistoryObject)
		}
		historyObjects = creativeHistoryObjects

	default:
		w.WriteHeader(http.StatusBadRequest)
		json.NewEncoder(w).Encode("Invalid history type")
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(historyObjects)
}
