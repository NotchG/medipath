package controller

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetDoctors(c *gin.Context) {
	// Dummy data (ganti dengan fetch dari DB nanti)
	doctors := []gin.H{
		{"id": "uuid-1", "name": "Dr. John Doe", "specialization": "Cardiology", "experience": 10, "rating": 4.8, "location": "Jakarta"},
		{"id": "uuid-2", "name": "Dr. Jane Smith", "specialization": "Neurology", "experience": 8, "rating": 4.7, "location": "Bandung"},
	}
	c.JSON(http.StatusOK, doctors)
}
