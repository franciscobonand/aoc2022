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
	fmt.Println(handleMotions(input))
	fmt.Println(handleManyKnotsMotions(input))
}

func handleManyKnotsMotions(input []string) int {
	var move string
	var distance int
	heads := getHeads()
	tail := []int{0, 0}
	seen := map[string]bool{"x0y0": true}
	for _, line := range input {
		fmt.Sscanf(line, "%s %d", &move, &distance)
		switch move {
		case "R":
			for i := 0; i < distance; i++ {
				heads[0][0] += 1
				for j := 0; j < 8; j++ {
					handleTailMove(heads[j+1], heads[j])
				}
				handleTailMove(tail, heads[8])
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		case "L":
			for i := 0; i < distance; i++ {
				heads[0][0] -= 1
				for j := 0; j < 8; j++ {
					handleTailMove(heads[j+1], heads[j])
				}
				handleTailMove(tail, heads[8])
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		case "U":
			for i := 0; i < distance; i++ {
				heads[0][1] += 1
				for j := 0; j < 8; j++ {
					handleTailMove(heads[j+1], heads[j])
				}
				handleTailMove(tail, heads[8])
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		case "D":
			for i := 0; i < distance; i++ {
				heads[0][1] -= 1
				for j := 0; j < 8; j++ {
					handleTailMove(heads[j+1], heads[j])
				}
				handleTailMove(tail, heads[8])
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		}
	}
	return len(seen)
}

func handleMotions(input []string) int {
	var move string
	var distance int
	head := []int{0, 0}
	tail := []int{0, 0}
	seen := map[string]bool{"x0y0": true}
	for _, line := range input {
		fmt.Sscanf(line, "%s %d", &move, &distance)
		switch move {
		case "R":
			for i := 0; i < distance; i++ {
				head[0] += 1
				handleTailMove(tail, head)
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		case "L":
			for i := 0; i < distance; i++ {
				head[0] -= 1
				handleTailMove(tail, head)
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		case "U":
			for i := 0; i < distance; i++ {
				head[1] += 1
				handleTailMove(tail, head)
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		case "D":
			for i := 0; i < distance; i++ {
				head[1] -= 1
				handleTailMove(tail, head)
				idx := fmt.Sprintf("x%dy%d", tail[0], tail[1])
				seen[idx] = true
			}
		}
	}
	return len(seen)
}

func handleTailMove(tail, head []int) {
	xdist := Abs(tail[0], head[0])
	ydist := Abs(tail[1], head[1])
	if xdist <= 1 && ydist <= 1 {
		return
	}

	if tail[0] != head[0] && tail[1] != head[1] {
		switch {
		case tail[0] < head[0] && tail[1] < head[1]:
			tail[0]++
			tail[1]++
		case tail[0] < head[0] && tail[1] > head[1]:
			tail[0]++
			tail[1]--
		case tail[0] > head[0] && tail[1] < head[1]:
			tail[0]--
			tail[1]++
		case tail[0] > head[0] && tail[1] > head[1]:
			tail[0]--
			tail[1]--
		}
	} else if tail[0] != head[0] {
		move := head[0] - tail[0]
		if move > 0 {
			tail[0]++
			return
		}
		tail[0]--
	} else {
		if head[1]-tail[1] > 0 {
			tail[1]++
			return
		}
		tail[1]--
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

func Abs(x, y int) int {
	if x < y {
		return y - x
	}
	return x - y
}

func getHeads() [][]int {
	heads := make([][]int, 9)
	for i := 0; i < 9; i++ {
		heads[i] = make([]int, 2)
		heads[i] = []int{0, 0}
	}
	return heads
}
