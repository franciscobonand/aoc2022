package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

var getIdx = map[bool]func(int, int) string{
	true: func(rowIdx, colIdx int) string {
		return fmt.Sprintf("x%dy%d", rowIdx, colIdx)
	},
	false: func(rowIdx, colIdx int) string {
		return fmt.Sprintf("x%dy%d", colIdx, rowIdx)
	},
}

// TODO: make this shit run in parallel
func main() {
	input := getInput("input.txt")
	seen := make(map[string]bool, len(input)*len(input[0]))
	fillBorders(seen, len(input))
	checkRows(input, seen)
	checkColumns(input, seen)
	fmt.Println(countVisible(seen, len(input)))
}

func countVisible(seen map[string]bool, n int) int {
	count := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if seen[fmt.Sprintf("x%dy%d", i, j)] {
				count++
			}
		}
	}
	return count
}

func checkRows(seqs []string, seen map[string]bool) {
	for i, seq := range seqs {
		checkLeftView(i, seq, false, seen)
		checkRightView(i, seq, false, seen)
	}
}

// checkColumns checks transposed matrix (columns)
func checkColumns(seqs []string, seen map[string]bool) {
	str := ""
	for i := 0; i < len(seqs); i++ {
		for _, seq := range seqs {
			str = str + string(seq[i])
		}
		checkLeftView(i, str, true, seen)
		checkRightView(i, str, true, seen)
		str = ""
	}
}

func checkLeftView(currIdx int, seq string, isCol bool, seen map[string]bool) {
	highest := ""
	fIdx := getIdx[isCol]
	for i := 0; i < len(seq); i++ {
		idx := fIdx(currIdx, i)
		if string(seq[i]) > highest {
			highest = string(seq[i])
			seen[idx] = true
		}
	}
}

func checkRightView(currIdx int, seq string, isCol bool, seen map[string]bool) {
	highest := ""
	fIdx := getIdx[isCol]
	for i := len(seq) - 1; i >= 0; i-- {
		idx := fIdx(currIdx, i)
		if string(seq[i]) > highest {
			highest = string(seq[i])
			seen[idx] = true
		}
	}
}

func fillBorders(seen map[string]bool, n int) {
	for i := 0; i < n; i++ {
		seen[fmt.Sprintf("x%dy%d", i, 0)] = true
		seen[fmt.Sprintf("x%dy%d", i, n-1)] = true
		seen[fmt.Sprintf("x%dy%d", 0, i)] = true
		seen[fmt.Sprintf("x%dy%d", n-1, i)] = true
	}
}

func getInput(fileName string) []string {
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
	lines := strings.Split(content, "\n")
	return lines
}
