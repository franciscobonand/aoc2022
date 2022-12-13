package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

func main() {
	input := getInput("input.txt")
	home := createFilesystem(input)
	var totalSize int
	dfs(home, &totalSize, "")
	fmt.Println(totalSize)
}

func dfs(dir *directory, totalSize *int, ann string) int {
	for _, subDir := range dir.SubDirectories {
		dir.Size += dfs(subDir, totalSize, ann)
	}
	dir.Size += sumFileSizes(dir.Files)
	if dir.Size <= 100000 {
		*totalSize += dir.Size
	}
	// ann += "-"
	// fmt.Printf("%s%s (%d)\n", ann, dir.Path, dir.Size)
	return dir.Size
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
