package database

import (
	"fmt"
	"log"
	"os"

	"github.com/NotchG/medipath/backend/model"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDB() *gorm.DB {
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		// contoh default config lokal PostgreSQL
		dsn = "host=localhost user=postgres password=postgres dbname=medipath_db port=5432 sslmode=disable"
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database: ", err)
	}

	DB = db
	return db
}

func MigrateDB(db *gorm.DB) {
	err := db.AutoMigrate(
		&model.User{},
		&model.Doctor{},
		&model.Chat{},
	)
	if err != nil {
		log.Fatal("Failed to migrate database: ", err)
	}
	fmt.Println("✅ Database migrated")
}
