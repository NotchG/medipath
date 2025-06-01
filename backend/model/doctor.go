package model

import (
	"github.com/google/uuid"
	"gorm.io/gorm"
)

type Doctor struct {
	ID             uuid.UUID `gorm:"type:uuid;primaryKey" json:"id"`
	Name           string    `gorm:"not null" json:"name"`
	Specialization string    `gorm:"not null" json:"specialization"`
	Experience     int       `json:"experience"`
	Rating         float32   `json:"rating"`
	Location       string    `json:"location"`
}

func (doctor *Doctor) BeforeCreate(tx *gorm.DB) (err error) {
	doctor.ID = uuid.New()
	return
}
