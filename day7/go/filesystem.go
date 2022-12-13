package main

import (
	"fmt"
	"strconv"
	"strings"
)

type file struct {
	Name string
	Size int
}

type directory struct {
	Path           string
	Files          []file
	SubDirectories []*directory
	Size           int
}

func handleFile(line, currPath string, dirMap map[string]*directory) {
	args := strings.Split(line, " ")
	fileName := args[1]
	fileSize, err := strconv.Atoi(args[0])
	if err != nil {
		panic("Error converting file size to int")
	}

	newFile := file{
		Name: fileName,
		Size: fileSize,
	}

	dir, ok := dirMap[currPath]
	if !ok {
		dir = &directory{
			Path:           currPath,
			Files:          []file{},
			Size:           0,
			SubDirectories: []*directory{},
		}
	}
	dir.Files = append(dir.Files, newFile)

	dirMap[currPath] = dir
}

func handleDirectory(line, currPath string, dirMap map[string]*directory) {
	args := strings.Split(line, " ")
	var dirPath string
	if args[1] != "/" {
		dirPath = fmt.Sprintf("%s%s/", currPath, args[1])
	} else {
		dirPath = "/"
	}

	cmdDir, ok := dirMap[dirPath]
	if !ok {
		cmdDir = &directory{
			Path:           dirPath,
			Files:          []file{},
			SubDirectories: []*directory{},
			Size:           0,
		}
	}

	currDir, ok := dirMap[currPath]
	if !ok {
		currDir = &directory{
			Path:           currPath,
			Files:          []file{},
			Size:           0,
			SubDirectories: []*directory{},
		}
	}
	currDir.SubDirectories = append(currDir.SubDirectories, cmdDir)
	currDir.Size += cmdDir.Size
	dirMap[currPath] = currDir
	dirMap[dirPath] = cmdDir
}

func handleCommand(line string, currPath *string) {
	args := strings.Split(line, " ")
	if args[1] == "ls" {
		return
	}

	if args[2] == ".." {
		*currPath = getParentPath(*currPath)
		return
	}
	if args[2] != "/" {
		*currPath = fmt.Sprintf("%s%s/", *currPath, args[2])
		return
	}
	*currPath = "/"
}

func getParentPath(path string) string {
	pathParts := strings.Split(path, "/")
	newPathParts := pathParts[:len(pathParts)-2]
	return strings.Join(newPathParts, "/") + "/"
}
