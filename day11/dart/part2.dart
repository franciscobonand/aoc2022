import 'dart:io';

class Monkey {
  List<int> items;
  int divisibleBy;
  String worryOperation;
  int monkeyIndexToThrowIfTrue;
  int monkeyIndexToThrowIfFalse;
  int ammountOfItemsInspected = 0;

  Monkey({
    required this.items,
    required this.divisibleBy,
    required this.worryOperation,
    required this.monkeyIndexToThrowIfFalse,
    required this.monkeyIndexToThrowIfTrue,
  });

  addItem(int item) => items.add(item);

  throwAllItems() => items.clear();

  bool isDivisible(int x, supermod) => x % divisibleBy == 0;

  int calculateNewWorryLevel(int itemIndex, int supermod) {
    ammountOfItemsInspected++;
    final operationSplitted = worryOperation.split(' ');
    // final firstOperator = operationSplitted[0]; // acho que eh smp old
    final operation = operationSplitted[1];
    final secondOperator = operationSplitted[2];

    if (operation == '*') {
      if (secondOperator == 'old') {
        items[itemIndex] *= items[itemIndex];
      } else {
        items[itemIndex] *= int.parse(secondOperator);
      }
    } else if (operation == '+') {
      if (secondOperator == 'old') {
        items[itemIndex] += items[itemIndex];
      } else {
        items[itemIndex] += int.parse(secondOperator);
      }
    }

    items[itemIndex] %= supermod;

    return items[itemIndex];
  }

  @override
  String toString() {
    return ammountOfItemsInspected.toString();
  }
}

void main(List<String> args) {
  File file = new File('C:/Users/thiag/Desktop/aoc2022/day11/dart/input.txt');
  List<String> lines = file.readAsLinesSync();

  List<Monkey> monkeys = [];

  final numOfRounds = 10000;

  int supermod = 1;

  for (int i = 0; i < lines.length; i++) {
    final currentLine = lines[i];
    if (currentLine.contains('Monkey')) {
      final startingItems = lines[i + 1]
          .split(':')[1]
          .trim()
          .split(',')
          .map((e) => int.parse(e))
          .toList();
      final operation = lines[i + 2].split('=')[1].trim();
      final monkeyTest = int.parse(lines[i + 3].split('by')[1].trim());
      final monkeyIfTrue = int.parse(lines[i + 4].split('monkey')[1].trim());
      final monkeyIfFalse = int.parse(lines[i + 5].split('monkey')[1].trim());

      supermod *= monkeyTest;

      monkeys.add(
        Monkey(
          items: startingItems,
          divisibleBy: monkeyTest,
          worryOperation: operation,
          monkeyIndexToThrowIfFalse: monkeyIfFalse,
          monkeyIndexToThrowIfTrue: monkeyIfTrue,
        ),
      );
      i += 5;
    }
  }

  for (int round = 0; round < numOfRounds; round++) {
    for (int i = 0; i < monkeys.length; i++) {
      final currentMonkey = monkeys[i];
      int initialMonkeyItemsLength = currentMonkey.items.length;
      for (int itemCount = 0;
          itemCount < initialMonkeyItemsLength;
          itemCount++) {
        int newItemWorryLevel =
            currentMonkey.calculateNewWorryLevel(itemCount, supermod);
        if (currentMonkey.isDivisible(newItemWorryLevel, supermod)) {
          monkeys[currentMonkey.monkeyIndexToThrowIfTrue]
              .addItem(newItemWorryLevel);
        } else {
          monkeys[currentMonkey.monkeyIndexToThrowIfFalse]
              .addItem(newItemWorryLevel);
        }
      }
      currentMonkey.throwAllItems();
    }
  }

  int maxAmmount = 0;
  int secondMaxAmmount = 0;
  for (var monkey in monkeys) {
    if (monkey.ammountOfItemsInspected > maxAmmount) {
      secondMaxAmmount = maxAmmount;
      maxAmmount = monkey.ammountOfItemsInspected;
    } else if (monkey.ammountOfItemsInspected > secondMaxAmmount) {
      secondMaxAmmount = monkey.ammountOfItemsInspected;
    }
  }

  print(maxAmmount * secondMaxAmmount);
}
