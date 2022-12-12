import 'dart:io';

bool _isLastLine(int lineCounter, int linesLength) =>
    lineCounter == linesLength - 1;

void main(List<String> args) {
  int currentCalorie = 0;

  List<int> sumOfCalories = [];
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();

  for (int lineCounter = 0; lineCounter < lines.length; lineCounter++) {
    final line = lines[lineCounter];

    if (line.isEmpty) {
      sumOfCalories.add(currentCalorie);
      currentCalorie = 0;
    } else {
      currentCalorie += int.parse(line);
      if (_isLastLine(lineCounter, lines.length)) {
        sumOfCalories.add(currentCalorie);
      }
    }
  }

  sumOfCalories.sort((a, b) => b.compareTo(a));

  print('Parte 1 - Mais calorias: ${sumOfCalories[0]}');
  print(
      'Parte 2 - São ${sumOfCalories[0] + sumOfCalories[1] + sumOfCalories[2]} calorias');
}
