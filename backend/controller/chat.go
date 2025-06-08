package controller

import (
	"net/http"
	"time"

	"github.com/NotchG/medipath/backend/database"
	"github.com/NotchG/medipath/backend/model"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

func ChatWithAI(c *gin.Context) {
	var req struct {
		UserID  string `json:"user_id" binding:"required"`
		Message string `json:"message" binding:"required"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request: " + err.Error()})
		return
	}

	parsedUserID, err := uuid.Parse(req.UserID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID format"})
		return
	}

	userMessage := model.Chat{
		UserID:    parsedUserID,
		Role:      "user",
		Message:   req.Message,
		Timestamp: time.Now().UTC(),
	}
	if saveErr := database.DB.Create(&userMessage).Error; saveErr != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to save user message"})
		return
	}

	aiResponseText := "Ini jawaban AI untuk: " + req.Message

	aiMessage := model.Chat{
		UserID:    parsedUserID,
		Role:      "ai",
		Message:   aiResponseText,
		Timestamp: time.Now().UTC(),
	}
	if saveErr := database.DB.Create(&aiMessage).Error; saveErr != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to save AI response"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"response":        aiResponseText,
		"user_message_id": userMessage.ID,
		"ai_message_id":   aiMessage.ID,
		"timestamp":       time.Now().UTC(),
	})
}

// --- GetChatHistory ---
func GetChatHistory(c *gin.Context) {
	userIDStr := c.Query("user_id")

	if userIDStr == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "user_id is required"})
		return
	}

	parsedUserID, err := uuid.Parse(userIDStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID format"})
		return
	}

	var history []model.Chat
	if err := database.DB.Where("user_id = ?", parsedUserID).Order("timestamp asc").Find(&history).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch chat history"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"history": history})
}

func AddChatHistory(c *gin.Context) {
	var req model.Chat
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request: " + err.Error()})
		return
	}

	// Ensure UserID is valid UUID
	if _, err := uuid.Parse(req.UserID.String()); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID format"})
		return
	}

	if req.Timestamp.IsZero() {
		req.Timestamp = time.Now().UTC()
	}

	if err := database.DB.Create(&req).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add chat history"})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message": "Chat history added successfully",
		"chat":    req,
	})
}
