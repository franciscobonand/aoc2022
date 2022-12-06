package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

// Rock: A / X
// Paper: B / Y
// Scissors: C / Z
var outcomePoints = map[string]map[string]int{
	"A": {
		"X": 4,
		"Y": 8,
		"Z": 3,
	},
	"B": {
		"X": 1,
		"Y": 5,
		"Z": 9,
	},
	"C": {
		"X": 7,
		"Y": 2,
		"Z": 6,
	},
}

// X: Lose
// Y: Draw
// Z: Win
var matchPoints = map[string]map[string]int{
	"A": {
		"X": 3,
		"Y": 4,
		"Z": 8,
	},
	"B": {
		"X": 1,
		"Y": 5,
		"Z": 9,
	},
	"C": {
		"X": 2,
		"Y": 6,
		"Z": 7,
	},
}

func main() {
	totalOutcomeScore := getTotalOutcomeScore("input.txt")
	totalMatchScore := getTotalMatchScore("input.txt")

	fmt.Println("Score considering second column as the chosen SHAPE:")
	fmt.Println(totalOutcomeScore)
	fmt.Println("Score considering second column as the chosen RESULT:")
	fmt.Println(totalMatchScore)
}

func getTotalOutcomeScore(fileName string) int {
	input := getInput(fileName)
	totalScore := 0

	for _, set := range input {
		oponentShape := set[0]
		chosenShape := set[1]
		totalScore += outcomePoints[oponentShape][chosenShape]
	}

	return totalScore
}

func getTotalMatchScore(fileName string) int {
	input := getInput(fileName)
	totalScore := 0

	for _, set := range input {
		oponentShape := set[0]
		chosenResult := set[1]
		totalScore += matchPoints[oponentShape][chosenResult]
	}

	return totalScore

}

func getInput(fileName string) [][]string {
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
	return getMatches(content)
}

func getMatches(input string) [][]string {
	sets := strings.Split(input, "\n")
	matches := make([][]string, len(sets))

	// Split each set into a slice of strings
	for i, set := range sets {
		matches[i] = make([]string, len(set))
		matches[i] = strings.Split(set, " ")
	}

	return matches
}
