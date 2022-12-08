package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
)

func main() {
	input := getInput("input.txt")
	firstPacket := findStartPacket(input)
	fmt.Println("First marker starts after index", firstPacket)
	firstMessage := findStartMessage(input)
	fmt.Println("First message starts after index", firstMessage)
}

func findStartPacket(seq string) int {
	i := 0
	for i < len(seq)-4 {
		substr := seq[i : i+4]

		jump := findEqualMarker(substr)
		if jump == -1 {
			return i + 4
		}
		i += jump
	}

	return -1
}

func findStartMessage(seq string) int {
	i := 0
	for i < len(seq)-14 {
		substr := seq[i : i+14]

		jump := findEqualMarker(substr)
		if jump == -1 {
			return i + 14
		}
		i += jump
	}

	return -1
}

func findEqualMarker(s string) int {
	counts := make(map[rune][]int)
	for i, r := range s {
		counts[r] = append(counts[r], i)
	}

	for _, count := range counts {
		if len(count) > 1 {
			return count[0] + 1
		}
	}

	return -1
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
