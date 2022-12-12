import 'dart:io';

class Stack {
  List<String> _crates = [];

  String pop() {
    return _crates.removeAt(0);
  }

  String popAtIndex(int index) {
    return _crates.removeAt(index);
  }

  void insertAtFirstPosition(String item) {
    _crates.insert(0, item);
  }

  void insertAtLastPosition(String item) {
    _crates.add(item);
  }
}

void main(List<String> args) {
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();
  int firstInstructionIndex =
      lines.indexWhere((element) => element.contains('move'));
  int numOfContainers =
      int.parse(lines[firstInstructionIndex - 2].trimRight().split(' ').last);

  _solvePart1(numOfContainers, firstInstructionIndex, lines);

  _solvePart2(numOfContainers, firstInstructionIndex, lines);
}

void _solvePart2(
    int numOfContainers, int firstInstructionIndex, List<String> lines) {
  final stacks = List<Stack>.generate(numOfContainers, (index) => Stack());

  for (int i = 0; i < firstInstructionIndex - 2; i++) {
    final stringWithContainers = lines[i];
    int flag = 0;
    int containerCount = 0;
    for (int j = 0; j < stringWithContainers.length; j++) {
      flag++;
      if (stringWithContainers[j] != ' ') {
        stacks[containerCount]
            .insertAtLastPosition(stringWithContainers[j + 1]);
        j += 2;
        containerCount++;
        flag = -1;
      }
      if (flag == 3) {
        containerCount++;
        flag = -1;
      }
    }
  }

  for (int i = firstInstructionIndex; i < lines.length; i++) {
    final instructions = lines[i]
        .replaceAll('move ', '')
        .replaceAll('from ', '')
        .replaceAll('to ', '')
        .split(' ');

    final moveQuantity = int.parse(instructions[0]);
    final moveFrom = int.parse(instructions[1]) - 1;
    final moveTo = int.parse(instructions[2]) - 1;

    for (int i = 0; i < moveQuantity; i++) {
      if (moveQuantity > 1) {
        stacks[moveTo].insertAtFirstPosition(
            stacks[moveFrom].popAtIndex(moveQuantity - i - 1));
      } else {
        stacks[moveTo].insertAtFirstPosition(stacks[moveFrom].pop());
      }
    }
  }

  String answer = '';

  for (int i = 0; i < stacks.length; i++) {
    answer += stacks[i].pop();
  }

  print(answer);
}

void _solvePart1(
    int numOfContainers, int firstInstructionIndex, List<String> lines) {
  final stacks = List<Stack>.generate(numOfContainers, (index) => Stack());

  for (int i = 0; i < firstInstructionIndex - 2; i++) {
    final stringWithContainers = lines[i];
    int flag = 0;
    int containerCount = 0;
    for (int j = 0; j < stringWithContainers.length; j++) {
      flag++;
      if (stringWithContainers[j] != ' ') {
        stacks[containerCount]
            .insertAtLastPosition(stringWithContainers[j + 1]);
        j += 2;
        containerCount++;
        flag = -1;
      }
      if (flag == 3) {
        containerCount++;
        flag = -1;
      }
    }
  }

  for (int i = firstInstructionIndex; i < lines.length; i++) {
    final instructions = lines[i]
        .replaceAll('move ', '')
        .replaceAll('from ', '')
        .replaceAll('to ', '')
        .split(' ');
    final moveQuantity = int.parse(instructions[0]);
    final moveFrom = int.parse(instructions[1]) - 1;
    final moveTo = int.parse(instructions[2]) - 1;

    for (int i = 0; i < moveQuantity; i++) {
      stacks[moveTo].insertAtFirstPosition(stacks[moveFrom].pop());
    }
  }

  String answer = '';

  for (int i = 0; i < stacks.length; i++) {
    answer += stacks[i].pop();
  }

  print(answer);
}
