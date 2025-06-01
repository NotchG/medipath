package main

import (
	"fmt"
	"log"
	"os"

	"github.com/NotchG/medipath/backend/database"
	"github.com/NotchG/medipath/backend/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	db := database.ConnectDB()
	database.MigrateDB(db)

	router := gin.Default()

	// Setup API routes
	routes.SetupRoutes(router)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Println("Server running on port", port)
	if err := router.Run(":" + port); err != nil {
		log.Fatal("Failed to start server:", err)
	}
}
