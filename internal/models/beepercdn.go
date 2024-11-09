package models

import "time"

type BeeperPkgIndex struct {
	Version string `yaml:"version"`
	Files   []struct {
		URL          string `yaml:"url"`
		Sha512       string `yaml:"sha512"`
		Size         int    `yaml:"size"`
		BlockMapSize int    `yaml:"blockMapSize,omitempty"`
	} `yaml:"files"`
	Path        string    `yaml:"path"`
	Sha512      string    `yaml:"sha512"`
	ReleaseDate time.Time `yaml:"releaseDate"`
}
