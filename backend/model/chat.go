package model

import (
	"time"

	"github.com/google/uuid"
)

type Chat struct {
	ID        uint      `gorm:"primaryKey" json:"id"`
	UserID    uuid.UUID `gorm:"type:uuid;not null" json:"userId"`
	Role      string    `gorm:"not null" json:"role"`
	Message   string    `gorm:"type:text;not null" json:"message"`
	Timestamp time.Time `gorm:"not null;index" json:"timestamp"`
}
