import 'dart:io';

void main(List<String> args) {
  File file = new File('C:/Users/thiag/Desktop/aoc2022/day10/dart/input.txt');

  int currentCycle = 1;

  int x = 1;

  int totalSum = 0;

  List<int> cyclesToSum = [20, 60, 100, 140, 180, 220];

  List<String> lines = file.readAsLinesSync();

  for (var i = 0; i < lines.length; i++) {
    final currentLine = lines[i];

    if (cyclesToSum.contains(currentCycle)) {
      totalSum += currentCycle * x;
    }

    if (currentLine.split(" ")[0] == 'addx') {
      currentCycle++;
      if (cyclesToSum.contains(currentCycle)) {
        totalSum += currentCycle * x;
      }
      currentCycle++;
      x += int.parse(currentLine.split(" ")[1]);
      continue;
    }
    currentCycle++;
  }

  print(totalSum);
}
