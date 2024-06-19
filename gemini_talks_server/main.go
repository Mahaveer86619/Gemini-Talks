package main

import (
	"fmt"
	"net/http"

	"github.com/Mahaveer86619/Gemini-Talks/features"
)

func main() {
	mux := http.NewServeMux()
	fmt.Println("Starting server...")

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

`

func handleFunctions(mux *http.ServeMux) {
	mux.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprint(w, welcomeString)
	})

	//* Creative Gen
	mux.HandleFunc("POST /creative", features.CreateCreativeResponse)
}