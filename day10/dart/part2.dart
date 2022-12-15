import 'dart:io';

void main(List<String> args) {
  File file = new File('C:/Users/thiag/Desktop/aoc2022/day10/dart/input.txt');

  int currentCycle = 1;
  int crtDrawPosition = currentCycle - 1;
  int currentCrtRow = 0;

  int x = 1;

  int numOfRows = 6;
  int numOfColumns = 40;
  List<List<String>> crtPixels = List.generate(
      numOfRows, (i) => List.filled(numOfColumns, ' '),
      growable: false);
  List<String> sprite = List.filled(numOfColumns, ' ');
  sprite[0] = '#';
  sprite[1] = '#';
  sprite[2] = '#';

  List<String> lines = file.readAsLinesSync();

  void _updateSprite() {
    sprite = List.filled(40, '.');

    if (x >= 0 && x <= 39) sprite[x] = '#';
    if (x - 1 >= 0 && x - 1 <= 39) sprite[x - 1] = '#';
    if (x + 1 >= 0 && x + 1 <= 39) sprite[x + 1] = '#';
  }

  void _drawCrtPixel() {
    if (sprite[crtDrawPosition] == '#') {
      crtPixels[currentCrtRow][crtDrawPosition] = '#';
    }
    crtDrawPosition++;
    if (crtDrawPosition == 40 && currentCrtRow != 5) {
      crtDrawPosition = 0;
      currentCrtRow++;
    }
  }

  for (var i = 0; i < lines.length; i++) {
    final currentLine = lines[i];
    _drawCrtPixel();

    if (currentLine.split(" ")[0] == 'addx') {
      currentCycle++;

      _drawCrtPixel();
      x += int.parse(currentLine.split(" ")[1]);
      _updateSprite();
    }
    currentCycle++;
  }

  for (var line in crtPixels) {
    for (var char in line) {
      stdout.write(char + '  ');
    }
    print('\n');
  }
}
