package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

const (
	sizeToDelete = 5174025
	maxDirSize   = 100000
)

func main() {
	input := getInput("input.txt")
	home := createFilesystem(input)
	var totalSize int
	getTotalSize(home, &totalSize)
	fmt.Println("Total directory size sum:", totalSize)
	dirToDeleteSize := home.Size
	getDirToDelete(home, &dirToDeleteSize)
	fmt.Println("Size of directory to be deleted:", dirToDeleteSize)

}

// Part 1
func getTotalSize(dir *directory, totalSize *int) int {
	for _, subDir := range dir.SubDirectories {
		dir.Size += getTotalSize(subDir, totalSize)
	}
	dir.Size += sumFileSizes(dir.Files)
	if dir.Size <= maxDirSize {
		*totalSize += dir.Size
	}
	return dir.Size
}

// Part 2
func getDirToDelete(dir *directory, dirToDeleteSize *int) {
	size := dir.Size
	if size >= sizeToDelete && size < *dirToDeleteSize {
		*dirToDeleteSize = size
	}
	for _, subDir := range dir.SubDirectories {
		getDirToDelete(subDir, dirToDeleteSize)
	}
}

func sumFileSizes(files []file) int {
	sum := 0
	for _, file := range files {
		sum += file.Size
	}
	return sum
}

func createFilesystem(input string) *directory {
	lines := strings.Split(input, "\n")
	currPath := ""
	// used map so it's easier to find directories and modify them
	dirMap := map[string]*directory{}

	for _, line := range lines {
		switch line[0] {
		case '$':
			handleCommand(line, &currPath)
		case 'd':
			handleDirectory(line, currPath, dirMap)
		default:
			handleFile(line, currPath, dirMap)
		}
	}
	return dirMap["/"]
}

func getInput(fileName string) string {
	file, err := os.Open(fileName)
	if err != nil {
		panic("Error opening file")
	}
	defer file.Close()

	reader := bufio.NewReader(file)
	bContent, err := io.ReadAll(reader)
	if err != nil {
		panic("Error reading file")
	}

	return string(bContent)
}
