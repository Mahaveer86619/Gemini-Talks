package main

import (
	"fmt"
	"net/http"

	"github.com/Mahaveer86619/Gemini-Talks/features"
)

func main() {
	mux := http.NewServeMux()
	fmt.Println(welcomeString)

	handleFunctions(mux)

	if err := http.ListenAndServe(":4040", mux); err != nil {
		fmt.Println("Error starting server:", err)
	}
}

var welcomeString = `
 ________  _______   _____ ______   ___  ________   ___          _________  ________  ___       ___  __    ________      
|\   ____\|\  ___ \ |\   _ \  _   \|\  \|\   ___  \|\  \        |\___   ___\\   __  \|\  \     |\  \|\  \ |\   ____\     
\ \  \___|\ \   __/|\ \  \\\__\ \  \ \  \ \  \\ \  \ \  \       \|___ \  \_\ \  \|\  \ \  \    \ \  \/  /|\ \  \___|_    
 \ \  \  __\ \  \_|/_\ \  \\|__| \  \ \  \ \  \\ \  \ \  \           \ \  \ \ \   __  \ \  \    \ \   ___  \ \_____  \   
  \ \  \|\  \ \  \_|\ \ \  \    \ \  \ \  \ \  \\ \  \ \  \           \ \  \ \ \  \ \  \ \  \____\ \  \\ \  \|____|\  \  
   \ \_______\ \_______\ \__\    \ \__\ \__\ \__\\ \__\ \__\           \ \__\ \ \__\ \__\ \_______\ \__\\ \__\____\_\  \ 
    \|_______|\|_______|\|__|     \|__|\|__|\|__| \|__|\|__|            \|__|  \|__|\|__|\|_______|\|__| \|__|\_________\
                                                                                                             \|_________|
Serving at: http://192.168.29.150:4040

Running in development mode

Endpoints:

/allHistory 		(GET) 				- Get creative or chat history, send user_uid and type in query params
/history 			(GET) 				- Get creative or chat history, send id and type in query params
/creativeHistory 	(POST) 				- Save creative history, send in body
/chatHistory 		(POST) 				- Save chat history, send in body
/templates 			(GET and POST) 		- Upload and get 4 templates 
/creative 			(POST) 				- Create creative response with given prompt in body
/chat 				(POST) 				- Create chat response with given prompt in body

`

func handleFunctions(mux *http.ServeMux) {
	mux.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, welcomeString)
	})

	//* Templates
	mux.HandleFunc("GET /templates", features.HandleTemplates)
	mux.HandleFunc("POST /templates", features.HandleTemplates)

	//* History
	mux.HandleFunc("GET /allHistory", features.GetAllHistory)
	mux.HandleFunc("GET /history", features.GetHistory)
	mux.HandleFunc("POST /creativeHistory", features.SaveCreativeHistory)
	mux.HandleFunc("POST /chatHistory", features.SaveChatHistory)

	//* Chat
	mux.HandleFunc("POST /chat", features.HandleChat)

	//* Creative Gen
	mux.HandleFunc("POST /creative", features.CreateCreativeResponse)
}
