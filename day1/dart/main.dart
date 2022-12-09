import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  int auxCalories = 0;

  List<int> somasCalorias = [];

  await new File('input.txt')
      .openRead()
      .transform(utf8.decoder)
      .transform(new LineSplitter())
      .forEach(
    (l) async {
      if (l.isEmpty) {
        somasCalorias.add(auxCalories);

        auxCalories = 0;
      } else {
        auxCalories += int.parse(l);
      }
    },
  );
  somasCalorias.sort((a, b) => b.compareTo(a));

  print('Parte 1 - Mais calorias: ${somasCalorias[0]}');
  print(
      'Parte 2 - São ${somasCalorias[0] + somasCalorias[1] + somasCalorias[2]} calorias');
}
