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

type TreeInfo struct {
	Seen bool
	TTL  int
	TTR  int
	TTT  int
	TTB  int
}

// TODO: make this shit run in parallel
func main() {
	input := getInput("input.txt")
	trees := map[string]*TreeInfo{}
	initializeTrees(trees, len(input))
	fillBorders(trees, len(input))
	checkRows(input, trees)
	checkColumns(input, trees)
	fmt.Println(countVisible(trees, len(input)))
	fmt.Println(getHighestScenicScore(trees, len(input)))
}

func countVisible(trees map[string]*TreeInfo, n int) int {
	count := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if trees[fmt.Sprintf("x%dy%d", i, j)].Seen {
				count++
			}
		}
	}
	return count
}

func getHighestScenicScore(trees map[string]*TreeInfo, n int) int {
	max := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			tree := trees[fmt.Sprintf("x%dy%d", i, j)]
			score := tree.TTL * tree.TTR * tree.TTT * tree.TTB
			if score > max {
				max = score
			}
		}
	}
	return max
}

func checkRows(seqs []string, trees map[string]*TreeInfo) {
	for i, seq := range seqs {
		checkLeftView(i, seq, false, trees)
		checkRightView(i, seq, false, trees)
	}
}

// checkColumns checks transposed matrix (columns)
func checkColumns(seqs []string, trees map[string]*TreeInfo) {
	str := ""
	for i := 0; i < len(seqs); i++ {
		for _, seq := range seqs {
			str = str + string(seq[i])
		}
		checkLeftView(i, str, true, trees)
		checkRightView(i, str, true, trees)
		str = ""
	}
}

func checkLeftView(currIdx int, seq string, isCol bool, trees map[string]*TreeInfo) {
	highest := ""
	fIdx := getIdx[isCol]
	for i := 0; i < len(seq); i++ {
		idx := fIdx(currIdx, i)
		if string(seq[i]) > highest {
			highest = string(seq[i])
			trees[idx].Seen = true
		}
		for j := i - 1; j >= 0; j-- {
			if isCol {
				trees[idx].TTT++
			} else {
				trees[idx].TTL++
			}
			if string(seq[i]) <= string(seq[j]) {
				break
			}
		}
	}
}

func checkRightView(currIdx int, seq string, isCol bool, trees map[string]*TreeInfo) {
	highest := ""
	fIdx := getIdx[isCol]
	for i := len(seq) - 1; i >= 0; i-- {
		idx := fIdx(currIdx, i)
		if string(seq[i]) > highest {
			highest = string(seq[i])
			trees[idx].Seen = true
		}
		for j := i + 1; j < len(seq); j++ {
			if isCol {
				trees[idx].TTB++
			} else {
				trees[idx].TTR++
			}
			if string(seq[i]) <= string(seq[j]) {
				break
			}
		}
	}
}

func fillBorders(trees map[string]*TreeInfo, n int) {
	for i := 0; i < n; i++ {
		trees[fmt.Sprintf("x%dy%d", i, 0)].Seen = true
		trees[fmt.Sprintf("x%dy%d", i, n-1)].Seen = true
		trees[fmt.Sprintf("x%dy%d", 0, i)].Seen = true
		trees[fmt.Sprintf("x%dy%d", n-1, i)].Seen = true
	}
}

func initializeTrees(trees map[string]*TreeInfo, n int) {
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			trees[fmt.Sprintf("x%dy%d", i, j)] = &TreeInfo{}
		}
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
