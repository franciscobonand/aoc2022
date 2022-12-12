import 'dart:io';

const SUBTRACT_LOWER_CASE_CONSTANT = 96;
const SUBTRACT_UPPER_CASE_CONSTANT = 38;

void main(List<String> args) {
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();

  _part1Resolution(lines);
  _part2Resolution(lines);
}

void _part1Resolution(List<String> lines) {
  int sumOfPriorities = 0;

  for (var lineCounter = 0; lineCounter < lines.length; lineCounter++) {
    final currentLine = lines[lineCounter];
    final itemQuantity = currentLine.length;
    final middleOfRucksack = itemQuantity / 2;

    Map<String, int> currentRucksack = {};

    String itemShared = '';

    for (var i = 0; i < itemQuantity; i++) {
      if (i < middleOfRucksack) {
        currentRucksack[currentLine[i]] = 1;
      } else {
        if (currentRucksack.containsKey(currentLine[i])) {
          itemShared = currentLine[i];
          break;
        }
      }
    }

    final itemSharedCodeUnit = itemShared.codeUnits.first;

    sumOfPriorities += _calculatePriorityValue(itemSharedCodeUnit);
  }
  print(sumOfPriorities);
}

void _part2Resolution(List<String> lines) {
  int sumOfPriorities = 0;

  Set<int> firstElfRucksack = {};
  Set<int> secondElfRucksack = {};
  Set<int> thirdElfRucksack = {};

  for (var lineCounter = 0; lineCounter < lines.length; lineCounter++) {
    final currentLine = lines[lineCounter];
    if (lineCounter % 3 == 0) {
      firstElfRucksack.addAll(currentLine.codeUnits);
    }
    if (lineCounter % 3 == 1) {
      secondElfRucksack.addAll(currentLine.codeUnits);
    }
    if (lineCounter % 3 == 2) {
      thirdElfRucksack.addAll(currentLine.codeUnits);

      final badgeCodeUnit = firstElfRucksack
          .intersection(secondElfRucksack)
          .intersection(thirdElfRucksack)
          .first;
      sumOfPriorities += _calculatePriorityValue(badgeCodeUnit);
      firstElfRucksack.clear();
      secondElfRucksack.clear();
      thirdElfRucksack.clear();
    }
  }
  print(sumOfPriorities);
}

int _calculatePriorityValue(int value) {
  if (value > 96) {
    return value - SUBTRACT_LOWER_CASE_CONSTANT;
  }

  return value - SUBTRACT_UPPER_CASE_CONSTANT;
}
