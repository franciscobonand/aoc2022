package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

const (
	QNT  = 0
	FROM = 1
	TO   = 2
)

func main() {
	stack := (rearrangeStacks("input.txt"))
	printTopItems(stack)

	stackMulti := (rearrangeStacksMultiple("input.txt"))
	printTopItems(stackMulti)
}

// Part 1
func rearrangeStacks(fileName string) []Stack {
	stk, mv := getInput(fileName, getStacksAndMoves)
	for _, m := range mv {
		qnt, from, to := m[QNT], m[FROM]-1, m[TO]-1
		if qnt == 0 {
			continue
		}
		for i := 0; i < qnt; i++ {
			item := stk[from].Pop()
			stk[to].Push(item)
		}
	}
	return stk
}

// Part 2
func rearrangeStacksMultiple(fileName string) []Stack {
	stk, mv := getInput(fileName, getStacksAndMoves)
	for _, m := range mv {
		qnt, from, to := m[QNT], m[FROM]-1, m[TO]-1
		if qnt == 0 {
			continue
		}
		items := stk[from].PopGivenQuantity(qnt)
		for _, item := range items {
			stk[to].Push(item)
		}
	}
	return stk
}

// Utils
func getInput(fileName string, f func(string) ([]Stack, [][]int)) ([]Stack, [][]int) {
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

func getStacksAndMoves(content string) ([]Stack, [][]int) {
	data := strings.Split(content, "\n\n")
	stk := data[0]
	mvStr := data[1]

	stacks := getStacks(stk)
	moves := getMoves(mvStr)

	return stacks, moves
}

func getMoves(mvStr string) [][]int {
	sets := strings.Split(mvStr, "\n")
	moves := make([][]int, len(sets))

	for i, set := range sets {
		moves[i] = make([]int, 3)
		var qnt, from, to int
		moves[i] = make([]int, 3)
		fmt.Sscanf(set, "move %d from %d to %d", &qnt, &from, &to)
		moves[i] = []int{qnt, from, to}

	}
	return moves
}

func getStacks(stk string) []Stack {
	sets := strings.Split(stk, "\n")
	// get number of stacks
	lastLine := strings.Split(sets[len(sets)-1], " ")
	nStacks, err := strconv.Atoi(lastLine[len(lastLine)-2])
	checkErr(err)

	sets = sets[:len(sets)-1]
	stacks := make([]Stack, nStacks)

	k := 0
	for j := 1; j < len(sets[0]); j += 4 {
		for i := len(sets) - 1; i >= 0; i-- {
			if string(sets[i][j]) != " " {
				stacks[k].Push(string(sets[i][j]))
			}
		}
		k++
	}

	return stacks
}

func printTopItems(stk []Stack) {
	for _, s := range stk {
		fmt.Printf("%s ", s.Pop())
	}
	fmt.Println()
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}
