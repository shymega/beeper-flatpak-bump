package main

import (
	"fmt"
	yaml "github.com/goccy/go-yaml"
	"github.com/shymega/beeper-flatpak-bump-ver/internal/models"
	"io"
	"net/http"
)

const BEEPER_PKG_INDEX_URL = "https://download.todesktop.com/2003241lzgn20jd/latest-linux.yml"

func getBeeperPkgIndex() (models.BeeperPkgIndex, error) {
	resp, err := http.Get(BEEPER_PKG_INDEX_URL)
	if err != nil {
		return models.BeeperPkgIndex{}, err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return models.BeeperPkgIndex{}, err
	}
	var pkgIndex models.BeeperPkgIndex
	if err := yaml.Unmarshal(body, &pkgIndex); err != nil {
		return models.BeeperPkgIndex{}, err
	}
	return pkgIndex, nil
}

func main() {
	pkgIndex, err := getBeeperPkgIndex()
	if err != nil {
		/* handle error */
		panic(err)
	}

	fmt.Printf("URL: %s\nSHA-512: %s\n", pkgIndex.Path, pkgIndex.Sha512)
}
