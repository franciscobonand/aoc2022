package main

import "testing"

// Previous benchmark results:
// BenchmarkGetMostCalories-8                  6177            203796 ns/op
// BenchmarkGetTopThreeCalories-8              4098            259663 ns/op

// New benchmark results:
// BenchmarkGetMostCalories-8                  8817            163601 ns/op
// BenchmarkGetTopThreeCalories-8              7323            164180 ns/op

func BenchmarkGetMostCalories(b *testing.B) {
	for i := 0; i < b.N; i++ {
		getMostCalories("input.txt")
	}
}

func BenchmarkGetTopThreeCalories(b *testing.B) {
	for i := 0; i < b.N; i++ {
		getTopThreeCalories("input.txt")
	}
}
