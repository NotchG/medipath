package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func Login(c *gin.Context) {
	var req struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return
	}

	// Dummy validasi username & password (replace dengan DB query & password hash check)
	if req.Username == "user" && req.Password == "password" {
		c.JSON(http.StatusOK, gin.H{
			"token": "dummy-jwt-token",
			"user": gin.H{
				"id":       "uuid-placeholder",
				"username": req.Username,
			},
		})
		return
	}

	c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
}
