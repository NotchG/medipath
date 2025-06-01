package controller

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func ChatWithAI(c *gin.Context) {
	var req struct {
		UserID  string `json:"user_id"`
		Message string `json:"message"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// Simulasi jawaban AI
	response := "Ini jawaban AI untuk: " + req.Message

	// Simulasi simpan chat ke DB (belum implementasi)
	chatID := uuid.New().String()

	// Return response dan chat_id
	c.JSON(http.StatusOK, gin.H{
		"response":  response,
		"chat_id":   chatID,
		"timestamp": time.Now().UTC(),
	})
}

func GetChatHistory(c *gin.Context) {
	// Simulasi data chat (ganti dengan fetch dari DB nanti)
	history := []gin.H{
		{
			"chat_id":   "uuid-123",
			"user_id":   "uuid-user",
			"message":   "Apa itu hipertensi?",
			"response":  "Hipertensi adalah tekanan darah tinggi...",
			"timestamp": "2025-06-02T10:00:00Z",
		},
	}
	c.JSON(http.StatusOK, history)
}
