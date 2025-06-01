package model

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Chat struct {
	ID        uuid.UUID `gorm:"type:uuid;primaryKey" json:"chat_id"`
	UserID    uuid.UUID `gorm:"type:uuid;not null" json:"user_id"`
	Message   string    `gorm:"type:text;not null" json:"message"`
	Response  string    `gorm:"type:text" json:"response"`
	Timestamp time.Time `gorm:"autoCreateTime" json:"timestamp"`
}

func (chat *Chat) BeforeCreate(tx *gorm.DB) (err error) {
	if chat.ID == uuid.Nil {
		chat.ID = uuid.New()
	}
	return nil
}
