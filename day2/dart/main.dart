import 'dart:io';

const int DRAW = 3;
const int WIN = 6;
const int LOST = 0;

const int POINTS_FOR_X = 1;
const int POINTS_FOR_Y = 2;
const int POINTS_FOR_Z = 3;

const answerSheetPart1 = {
  'A': {
    'X': DRAW + POINTS_FOR_X,
    'Y': WIN + POINTS_FOR_Y,
    'Z': LOST + POINTS_FOR_Z,
  },
  'B': {
    'X': LOST + POINTS_FOR_X,
    'Y': DRAW + POINTS_FOR_Y,
    'Z': WIN + POINTS_FOR_Z,
  },
  'C': {
    'X': WIN + POINTS_FOR_X,
    'Y': LOST + POINTS_FOR_Y,
    'Z': DRAW + POINTS_FOR_Z,
  },
};

const answerSheetPart2 = {
  'A': {
    // PEDRA
    'X': LOST + POINTS_FOR_Z,
    'Y': DRAW + POINTS_FOR_X,
    'Z': WIN + POINTS_FOR_Y,
  },
  'B': {
    // PAPEL
    'X': LOST + POINTS_FOR_X,
    'Y': DRAW + POINTS_FOR_Y,
    'Z': WIN + POINTS_FOR_Z,
  },
  'C': {
    // TESOURA
    'X': LOST + POINTS_FOR_Y,
    'Y': DRAW + POINTS_FOR_Z,
    'Z': WIN + POINTS_FOR_X,
  },
};

void main(List<String> args) {
  File file = new File('input.txt');
  int sumOfScoresPart1 = 0;
  int sumOfScoresPart2 = 0;

  List<String> lines = file.readAsLinesSync();

  sumOfScoresPart1 = lines.map((e) {
    List<String> moves = e.split(' ');
    final opponentMove = moves[0];
    final yourMove = moves[1];
    return answerSheetPart1[opponentMove]![yourMove]!;
  }).reduce((value, element) => value + element);

  sumOfScoresPart2 = lines.map((e) {
    List<String> moves = e.split(' ');
    final opponentMove = moves[0];
    final yourMove = moves[1];
    return answerSheetPart2[opponentMove]![yourMove]!;
  }).reduce((value, element) => value + element);

  print('Parte 1: ${sumOfScoresPart1}');
  print('Parte 2: ${sumOfScoresPart2}');
}
