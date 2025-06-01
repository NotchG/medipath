package routes

import (
	"github.com/gin-gonic/gin"

	"github.com/NotchG/medipath/backend/controller"
)

func SetupRoutes(router *gin.Engine) {
	api := router.Group("/api")

	// Auth
	api.POST("/login", controller.Login)

	// Doctor
	api.GET("/doctors", controller.GetDoctors)

	// Chat
	api.POST("/chat", controller.ChatWithAI)
	api.GET("/chat/history", controller.GetChatHistory)
}
