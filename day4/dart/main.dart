import 'dart:io';

void main(List<String> args) {
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();

  _solvePart1(lines);

  _solvePart2(lines);
}

void _solvePart1(List<String> lines) {
  int sumOfRepeatingSections = 0;

  for (String line in lines) {
    final splittedSections = line.split(',');

    final firstElfSectionRange = splittedSections[0];
    final secondElfSectionRange = splittedSections[1];

    final firstElfSections = firstElfSectionRange.split('-');
    final secondElfSections = secondElfSectionRange.split('-');

    final firstElfFirstNumber = int.parse(firstElfSections[0]);
    final firstElfSecondNumber = int.parse(firstElfSections[1]);
    final secondElfFirstNumber = int.parse(secondElfSections[0]);
    final secondElfSecondNumber = int.parse(secondElfSections[1]);

    if (firstElfFirstNumber >= secondElfFirstNumber) {
      if (firstElfSecondNumber <= secondElfSecondNumber) {
        sumOfRepeatingSections++;
        continue;
      }
    }

    if (secondElfFirstNumber >= firstElfFirstNumber) {
      if (secondElfSecondNumber <= firstElfSecondNumber) {
        sumOfRepeatingSections++;
      }
    }
  }

  print('Parte 1: ${sumOfRepeatingSections}');
}

void _solvePart2(List<String> lines) {
  int sumOfRepeatingSections = 0;

  for (String line in lines) {
    final splittedSections = line.split(',');

    final firstElfSectionRange = splittedSections[0];
    final secondElfSectionRange = splittedSections[1];

    final firstElfSections = firstElfSectionRange.split('-');
    final secondElfSections = secondElfSectionRange.split('-');

    final firstElfFirstNumber = int.parse(firstElfSections[0]);
    final firstElfSecondNumber = int.parse(firstElfSections[1]);
    final secondElfFirstNumber = int.parse(secondElfSections[0]);
    final secondElfSecondNumber = int.parse(secondElfSections[1]);

    Set<int> firstRange = {};
    Set<int> secondRange = {};

    for (var i = firstElfFirstNumber; i <= firstElfSecondNumber; i++) {
      firstRange.add(i);
    }
    for (var i = secondElfFirstNumber; i <= secondElfSecondNumber; i++) {
      secondRange.add(i);
    }

    if (firstRange.intersection(secondRange).isNotEmpty) {
      sumOfRepeatingSections++;
    }
  }
  print('Parte 2: ${sumOfRepeatingSections}');
}
