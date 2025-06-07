package controller

import (
	"net/http"
	"time"

	"github.com/NotchG/medipath/backend/model"
	"github.com/NotchG/medipath/backend/database"
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
	userID := c.Query("user_id") // Ambil user_id dari query string

	if userID == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "user_id is required"})
		return
	}

	var history []model.Chat
	if err := database.DB.Where("user_id = ?", userID).Order("timestamp desc").Find(&history).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch chat history"})
		return
	}

	c.JSON(http.StatusOK, history)
}
