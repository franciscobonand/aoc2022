import 'dart:io';

class Knot {
  final Knot? relativeTail;
  Set<String> uniquePositions = {'x0y0'};
  int currentXPosition = 0;
  int currentYPosition = 0;
  Knot(this.relativeTail);

  get x => currentXPosition;
  get y => currentYPosition;

  setCurrentXPosition(int x) => currentXPosition = x;
  setCurrentYPosition(int y) => currentYPosition = y;

  addUniquePosition() => uniquePositions.add(
      'x' + currentXPosition.toString() + 'y' + currentYPosition.toString());
}

void main() {
  File file = new File('C:/Users/thiag/Desktop/aoc2022/day9/dart/input.txt');

  List<String> lines = file.readAsLinesSync();

  final Knot tailKnot = Knot(null);
  final Knot knot9 = Knot(tailKnot);
  final Knot knot8 = Knot(knot9);
  final Knot knot7 = Knot(knot8);
  final Knot knot6 = Knot(knot7);
  final Knot knot5 = Knot(knot6);
  final Knot knot4 = Knot(knot5);
  final Knot knot3 = Knot(knot4);
  final Knot knot2 = Knot(knot3);
  final Knot headKnot = Knot(knot2);

  for (int i = 0; i < lines.length; i++) {
    final instructions = lines[i].split(' ');
    final direction = instructions[0];
    final moveQuantitiy = int.parse(instructions[1]);

    switch (direction) {
      case 'R':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentXPosition(headKnot.currentXPosition + 1);
          _moveRope(headKnot);
        }
        break;
      case 'L':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentXPosition(headKnot.currentXPosition - 1);
          _moveRope(headKnot);
        }
        break;
      case 'U':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentYPosition(headKnot.currentYPosition + 1);
          _moveRope(headKnot);
        }
        break;
      case 'D':
        for (int j = 0; j < moveQuantitiy; j++) {
          headKnot.setCurrentYPosition(headKnot.currentYPosition - 1);
          _moveRope(headKnot);
        }
        break;
      default:
    }
  }

  print('Part2: ${tailKnot.uniquePositions.length}');
}

_moveRope(Knot headKnot) {
  bool firstIteration = true;
  Knot? currentKnot = headKnot;

  while (currentKnot!.relativeTail != null) {
    firstIteration
        ? firstIteration = false
        : currentKnot = currentKnot.relativeTail;
    if (currentKnot!.relativeTail == null) break;
    final headX = currentKnot.currentXPosition;
    final tailX = currentKnot.relativeTail!.currentXPosition;
    final headY = currentKnot.currentYPosition;
    final tailY = currentKnot.relativeTail!.currentYPosition;

    if (headX == tailX && headY == tailY) continue;

    if ((headX - tailX).abs() <= 1 && (headY - tailY).abs() <= 1) continue;

    // If the head is ever two steps directly up, down, left, or right from the tail,
    // the tail must also move one step in that direction so it remains close enough:
    if (headX == tailX && headY > tailY) {
      currentKnot.relativeTail!.setCurrentYPosition(tailY + 1);
      currentKnot.relativeTail!.addUniquePosition();
      continue;
    }
    if (headX == tailX && headY < tailY) {
      currentKnot.relativeTail!.setCurrentYPosition(tailY - 1);
      currentKnot.relativeTail!.addUniquePosition();
      continue;
    }
    if (headY == tailY && headX > tailX) {
      currentKnot.relativeTail!.setCurrentXPosition(tailX + 1);
      currentKnot.relativeTail!.addUniquePosition();
      continue;
    }
    if (headY == tailY && headX < tailX) {
      currentKnot.relativeTail!.setCurrentXPosition(tailX - 1);
      currentKnot.relativeTail!.addUniquePosition();
      continue;
    }
    // Otherwise, if the head and tail aren't touching and aren't in the same row or column,
    // the tail always moves one step diagonally to keep up:
    headX < tailX
        ? currentKnot.relativeTail!.setCurrentXPosition(tailX - 1)
        : currentKnot.relativeTail!.setCurrentXPosition(tailX + 1);
    headY < tailY
        ? currentKnot.relativeTail!.setCurrentYPosition(tailY - 1)
        : currentKnot.relativeTail!.setCurrentYPosition(tailY + 1);
    currentKnot.relativeTail!.addUniquePosition();
    continue;
  }
}
