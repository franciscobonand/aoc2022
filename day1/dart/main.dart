import 'dart:io';

bool _isLastLine(int lineCounter, int linesLength) =>
    lineCounter == linesLength - 1;

Future<void> main(List<String> args) async {
  int auxCalories = 0;

  List<int> somasCalorias = [];
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();

  for (int lineCounter = 0; lineCounter < lines.length; lineCounter++) {
    final line = lines[lineCounter];

    if (line.isEmpty) {
      somasCalorias.add(auxCalories);
      auxCalories = 0;
    } else {
      auxCalories += int.parse(line);
      if (_isLastLine(lineCounter, lines.length)) {
        somasCalorias.add(auxCalories);
      }
    }
  }

  somasCalorias.sort((a, b) => b.compareTo(a));

  print('Parte 1 - Mais calorias: ${somasCalorias[0]}');
  print(
      'Parte 2 - São ${somasCalorias[0] + somasCalorias[1] + somasCalorias[2]} calorias');
}
