package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

func main() {
	fmt.Println("Priority sum:")
	fmt.Println(getPrioritySum("input.txt"))
	fmt.Println("Group priority sum:")
	fmt.Println(getGroupPrioritySum("input.txt"))
}

// Part 1
func getPrioritySum(fileName string) int {
	comparts := getInput(fileName, getCompartments)
	sum := 0

	for _, comp := range comparts {
		sum += getPriority(comp[0], comp[1])
	}

	return sum
}

func getPriority(a, b string) int {
	priority := 0
	for l := range a {
		if strings.Contains(b, string(a[l])) {
			return getPriorityValue(int(a[l]))
		}
	}
	return priority
}

func getCompartments(input string) [][]string {
	sets := strings.Split(input, "\n")
	comparts := make([][]string, len(sets))

	for i, set := range sets {
		halfLen := len(set) / 2
		comparts[i] = make([]string, 2)
		comparts[i][0] = set[:halfLen]
		comparts[i][1] = set[halfLen:]
	}

	return comparts
}

// Part 2
func getGroupPrioritySum(fileName string) int {
	groups := getInput(fileName, getElvesGroups)
	sum := 0

	for _, group := range groups {
		sum += getGroupPriority(group)
	}

	return sum
}

func getGroupPriority(group []string) int {
	priority := 0
	for l := range group[0] {
		if strings.Contains(group[1], string(group[0][l])) && strings.Contains(group[2], string(group[0][l])) {
			return getPriorityValue(int(group[0][l]))
		}
	}
	return priority
}

func getElvesGroups(input string) [][]string {
	sets := strings.Split(input, "\n")
	groups := make([][]string, len(sets)/3)

	j := 0
	for i := 0; i <= len(sets)-3; i += 3 {
		groups[j] = make([]string, 3)
		groups[j] = []string{sets[i], sets[i+1], sets[i+2]}
		j++
	}

	return groups
}

// Utils
func getPriorityValue(val int) int {
	if val >= 65 && val <= 90 {
		return (val % 65) + 27
	}
	return (val % 97) + 1
}

func getInput(fileName string, f func(string) [][]string) [][]string {
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
