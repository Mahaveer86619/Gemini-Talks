package middleware

import (
	"context"
	"net/http"
	"strings"

	"github.com/Mahaveer86619/Gemini-Talks/config"
)

type contextKey string

const userContextKey = contextKey("user")

func VerifyToken(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        authHeader := r.Header.Get("Authorization")
        if authHeader == "" {
            http.Error(w, "Authorization header required", http.StatusUnauthorized)
            return
        }

        idToken := strings.TrimSpace(strings.Replace(authHeader, "Bearer", "", 1))
        authClient := config.GetAuthClient()
        token, err := authClient.VerifyIDToken(context.Background(), idToken)
        if err != nil {
            http.Error(w, "Invalid token", http.StatusUnauthorized)
            return
        }

        ctx := context.WithValue(r.Context(), userContextKey, token)
        next.ServeHTTP(w, r.WithContext(ctx))
    })
}
