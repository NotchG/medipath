package model

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type User struct {
	ID             uuid.UUID  `gorm:"type:uuid;primaryKey" json:"id"`
	FullName       string     `gorm:"not null" json:"full_name"`
	Email          string     `gorm:"unique;not null" json:"email"`
	Password       string     `gorm:"not null" json:"password"`
	Gender         *string    `json:"gender"`
	DateOfBirth    *time.Time `json:"dateOfBirth"`
	PhoneNumber    *string    `json:"phoneNumber"`
	Address        *string    `json:"address"`
	MedicalHistory []string   `gorm:"type:jsonb" json:"medicalHistory"`
}

func (user *User) BeforeCreate(tx *gorm.DB) (err error) {
	user.ID = uuid.New()
	return
}
