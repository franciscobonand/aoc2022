package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println("Fully overlaped pairs: ")
	fmt.Println(getFullOverlap("input.txt"))
	fmt.Println("Any overlaped pairs: ")
	fmt.Println(getAnyOverlap("input.txt"))
}

// Second part
func getAnyOverlap(fileName string) int {
	pairs := getInput(fileName, getPairs)
	overlap := 0

	for _, pair := range pairs {
		if (pair[1] >= pair[2] && pair[1] <= pair[3]) ||
			(pair[0] >= pair[2] && pair[0] <= pair[3]) ||
			isFullyOverlaped(pair) {
			overlap++
		}
	}

	return overlap
}

// First part
func getFullOverlap(fileName string) int {
	pairs := getInput(fileName, getPairs)
	overlap := 0

	for _, pair := range pairs {
		if isFullyOverlaped(pair) {
			overlap++
		}
	}

	return overlap
}

// Utils
func isFullyOverlaped(pair []int) bool {
	return (pair[0] >= pair[2] && pair[1] <= pair[3]) ||
		(pair[0] <= pair[2] && pair[1] >= pair[3])
}

func getInput(fileName string, f func(string) [][]int) [][]int {
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

	content := string(bContent)
	return f(content)
}

func getPairs(input string) [][]int {
	lines := strings.Split(input, "\n")
	pairs := make([][]int, len(lines))

	for i, line := range lines {
		pairs[i] = make([]int, 0, 4)
		pair := strings.Split(line, ",")
		for _, item := range pair {
			nums := strings.Split(item, "-")
			n1, err := strconv.Atoi(nums[0])
			checkErr(err)
			n2, err := strconv.Atoi(nums[1])
			checkErr(err)
			pairs[i] = append(pairs[i], n1, n2)
		}
	}

	return pairs
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}
