import 'dart:io';

class Knot {
  Set<String> uniquePositions = {'x0y0'};
  int currentXPosition = 0;
  int currentYPosition = 0;
  Knot();

  setCurrentXPosition(int x) => currentXPosition = x;
  setCurrentYPosition(int y) => currentYPosition = y;

  addUniquePosition() => uniquePositions.add(
      'x' + currentXPosition.toString() + 'y' + currentYPosition.toString());
}

void main() {
  File file = new File('C:/Users/thiag/Desktop/aoc2022/day9/dart/input.txt');

  List<String> lines = file.readAsLinesSync();

  final Knot headKnot = Knot();
  final Knot tailKnot = Knot();

  for (int i = 0; i < lines.length; i++) {
    final instructions = lines[i].split(' ');
    final direction = instructions[0];
    final moveQuantitiy = int.parse(instructions[1]);

    switch (direction) {
      case 'R':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentXPosition(headKnot.currentXPosition + 1);
          _moveTail(headKnot, tailKnot);
        }
        break;
      case 'L':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentXPosition(headKnot.currentXPosition - 1);
          _moveTail(headKnot, tailKnot);
        }
        break;
      case 'U':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentYPosition(headKnot.currentYPosition + 1);
          _moveTail(headKnot, tailKnot);
        }
        break;
      case 'D':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentYPosition(headKnot.currentYPosition - 1);
          _moveTail(headKnot, tailKnot);
        }
        break;
      default:
    }
  }
  print('Part1: ${tailKnot.uniquePositions.length}');
}

_moveTail(Knot headKnot, Knot tailKnot) {
  final headX = headKnot.currentXPosition;
  final tailX = tailKnot.currentXPosition;
  final headY = headKnot.currentYPosition;
  final tailY = tailKnot.currentYPosition;

  if (headX == tailX && headY == tailY) return;

  if ((headX - tailX).abs() <= 1 && (headY - tailY).abs() <= 1) return;

  // If the head is ever two steps directly up, down, left, or right from the tail,
  // the tail must also move one step in that direction so it remains close enough:
  if (headX == tailX && headY > tailY) {
    tailKnot.setCurrentYPosition(tailY + 1);
    tailKnot.addUniquePosition();
    return;
  }
  if (headX == tailX && headY < tailY) {
    tailKnot.setCurrentYPosition(tailY - 1);
    tailKnot.addUniquePosition();
    return;
  }
  if (headY == tailY && headX > tailX) {
    tailKnot.setCurrentXPosition(tailX + 1);
    tailKnot.addUniquePosition();
    return;
  }
  if (headY == tailY && headX < tailX) {
    tailKnot.setCurrentXPosition(tailX - 1);
    tailKnot.addUniquePosition();
    return;
  }
  // Otherwise, if the head and tail aren't touching and aren't in the same row or column,
  // the tail always moves one step diagonally to keep up:
  headX < tailX
      ? tailKnot.setCurrentXPosition(tailX - 1)
      : tailKnot.setCurrentXPosition(tailX + 1);
  headY < tailY
      ? tailKnot.setCurrentYPosition(tailY - 1)
      : tailKnot.setCurrentYPosition(tailY + 1);
  tailKnot.addUniquePosition();
  return;
}
