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
	fmt.Println("Top calorie count:", maxCal)
	top3Cal := getTopThreeCalories("input.txt")
	fmt.Println("Top 3 calorie counts:", top3Cal)
}

// Part 1
func getMostCalories(file string) int {
	caloryGroups := getInput(file)
	groups := getOrderedCalorySumByGroup(caloryGroups)

	return groups[0]
}

// Part 2
func getTopThreeCalories(file string) int {
	caloryGroups := getInput(file)
	groups := getOrderedCalorySumByGroup(caloryGroups)

	return groups[0] + groups[1] + groups[2]
}

// Utils
func getInput(fileName string) []int {
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

func getCaloryGroups(input string) []int {
	sets := strings.Split(input, "\n\n")
	groups := make([][]string, len(sets))

	// Split each set into a slice of strings
	for i, set := range sets {
		group := strings.Split(set, "\n")
		groups[i] = make([]string, len(group))
		groups[i] = group
	}

	// Convert the strings in each set to integers
	intGroups := make([]int, len(groups))
	for i, set := range groups {
		intGroups[i] = 0
		for _, number := range set {
			num, err := strconv.Atoi(number)
			if err != nil {
				panic("Error converting string to int")
			}

			intGroups[i] += num
		}
	}

	return intGroups
}

// getOrderedCalorySumByGroup returns a slice of integers containing the sum of
// each group's calories, sorted in descending order.
func getOrderedCalorySumByGroup(groups []int) []int {
	sort.Slice(groups, func(i, j int) bool {
		return groups[i] > groups[j]
	})

	return groups
}
