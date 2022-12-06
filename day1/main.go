package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	maxCal := getMostCalories("input.txt")
	fmt.Println("Top calorie count:")
	fmt.Println(maxCal)
	fmt.Println("Top 3 calorie counts:")
	fmt.Println(getTopThreeCalories("input.txt"))
}

func getMostCalories(file string) int {
	caloryGroups := getInput(file)
	calSum := getOrderedCalorySumByGroup(caloryGroups)

	return calSum[0]
}

func getTopThreeCalories(file string) int {
	caloryGroups := getInput(file)
	calSum := getOrderedCalorySumByGroup(caloryGroups)

	return calSum[0] + calSum[1] + calSum[2]
}

func getInput(fileName string) [][]int {
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
	return getCaloryGroups(content)
}

func getCaloryGroups(input string) [][]int {
	sets := strings.Split(input, "\n\n")
	groups := make([][]string, len(sets))
	intGroups := make([][]int, len(sets))

	// Split each set into a slice of strings
	for i, set := range sets {
		groups[i] = make([]string, len(set))
		groups[i] = strings.Split(set, "\n")
	}

	// Convert the strings in each set to integers
	for i, set := range groups {
		intGroups[i] = make([]int, len(set))
		for j, number := range set {
			num, err := strconv.Atoi(number)
			if err != nil {
				panic("Error converting string to int")
			}

			intGroups[i][j] = num
		}
	}

	return intGroups
}

// getOrderedCalorySumByGroup returns a slice of integers containing the sum of
// each group's calories, sorted in descending order.
func getOrderedCalorySumByGroup(groups [][]int) []int {
	calSum := make([]int, len(groups))

	for i, group := range groups {
		for _, cal := range group {
			calSum[i] += cal
		}
	}

	sort.Slice(calSum, func(i, j int) bool {
		return calSum[i] > calSum[j]
	})

	return calSum
}