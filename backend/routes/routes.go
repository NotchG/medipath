package routes

import (
	"github.com/gin-gonic/gin"

	"github.com/NotchG/medipath/backend/controller"
)

func SetupRoutes(router *gin.Engine) {
	api := router.Group("/api")

	// Auth
	api.POST("/login", controller.Login)
	api.POST("/register", controller.Register)

	// Profile
	api.GET("/profile/:id", controller.GetProfile)
	api.PUT("/profile/:id", controller.UpdateProfile)

	// Chat
	api.POST("/chat", controller.ChatWithAI)
	api.GET("/chat/history", controller.GetChatHistory)
}
