package features

import (
	"context"
	"encoding/json"
	"math/rand"
	"net/http"
	"time"

	"github.com/Mahaveer86619/Gemini-Talks/config"
)

type Template struct {
	Title  string `json:"title"`
	Prompt string `json:"prompt"`
}

var TEMPLATE_COLLECTION = "templates"

func init() {
	rand.Seed(time.Now().UnixNano())
}

func HandleTemplates(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case "POST":
		addTemplate(w, r)
	case "GET":
		getTemplates(w, r)
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func addTemplate(w http.ResponseWriter, r *http.Request) {
	var template Template
	if err := json.NewDecoder(r.Body).Decode(&template); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	client := config.GetFirestoreClient()
	_, _, err := client.Collection(TEMPLATE_COLLECTION).Add(context.Background(), template)
	if err != nil {
		http.Error(w, "Failed to save template", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func getTemplates(w http.ResponseWriter, _ *http.Request) {
	client := config.GetFirestoreClient()
	iter := client.Collection(TEMPLATE_COLLECTION).Documents(context.Background())

	var templates []Template
	for {
		doc, err := iter.Next()
		if err != nil {
			break
		}
		var template Template
		doc.DataTo(&template)
		templates = append(templates, template)
	}

	if len(templates) < 4 {
		http.Error(w, "Not enough templates", http.StatusInternalServerError)
		return
	}

	shuffleTemplates(templates)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(templates[:4])
}

func shuffleTemplates(templates []Template) {
	for i := range templates {
		j := rand.Intn(i + 1)
		templates[i], templates[j] = templates[j], templates[i]
	}
}
