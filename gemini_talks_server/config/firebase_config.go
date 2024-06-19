package config

import (
	"context"
	"os"

	firestore "cloud.google.com/go/firestore"
	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"
	"github.com/joho/godotenv"
	"google.golang.org/api/option"
)

var (
	ctx    context.Context
	firestoreClient *firestore.Client
    authClient   *auth.Client
)

func init() {
	ctx = context.Background()
	godotenv.Load(".env")

	config := &firebase.Config{
		ProjectID: os.Getenv("FIREBASE_PROJECT_ID"),
	}
	opt := option.WithCredentialsFile(os.Getenv("GOOGLE_APPLICATION_CREDENTIALS"))

	var err error
	app, err := firebase.NewApp(ctx, config, opt)
	if err != nil {
		panic(err)
	}

	firestoreClient, err = app.Firestore(ctx)
	if err != nil {
		panic(err)
	}

	authClient, err = app.Auth(ctx)
    if err != nil {
        panic(err)
    }
}

func GetFirestoreClient() *firestore.Client {
	return firestoreClient
}

func GetAuthClient() *auth.Client {
	return authClient
}