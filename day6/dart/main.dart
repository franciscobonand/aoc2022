import 'dart:io';

void main(List<String> args) {
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();

  final String broadcast = lines.first;

  _solvePart1(broadcast);
  _solvePart2(broadcast);
}

void _solvePart1(String broadcast) {
  Map<String, int> currentMarkerMap = {};

  _populateInitialConfiguration(currentMarkerMap, broadcast, 4);

  _analyzeBroadcast(currentMarkerMap, broadcast, 4);
}

void _solvePart2(String broadcast) {
  Map<String, int> currentMarkerMap = {};

  _populateInitialConfiguration(currentMarkerMap, broadcast, 14);

  _analyzeBroadcast(currentMarkerMap, broadcast, 14);
}

void _populateInitialConfiguration(
    Map<String, int> currentMarkerMap, String broadcast, int patternLength) {
  for (int i = 0; i < patternLength; i++) {
    if (currentMarkerMap.containsKey(broadcast[i])) {
      currentMarkerMap[broadcast[i]] = currentMarkerMap[broadcast[i]]! + 1;
      continue;
    }
    currentMarkerMap[broadcast[i]] = 1;
  }
}

void _analyzeBroadcast(
    Map<String, int> currentMarkerMap, String broadcast, int patternLength) {
  if (currentMarkerMap.entries.length == patternLength) {
    print(patternLength);
  } else {
    for (int i = patternLength; i < broadcast.length; i++) {
      String nextLetter = broadcast[i];
      if (currentMarkerMap.containsKey(nextLetter)) {
        final currentValue = currentMarkerMap[nextLetter];
        currentMarkerMap[nextLetter] = currentValue! + 1;
      } else {
        currentMarkerMap[nextLetter] = 1;
      }

      String firstLetterInMarker = broadcast[i - patternLength];

      if (currentMarkerMap[firstLetterInMarker]! > 1) {
        final currentValue = currentMarkerMap[firstLetterInMarker]!;
        currentMarkerMap[firstLetterInMarker] = currentValue - 1;
      } else {
        currentMarkerMap.remove(firstLetterInMarker);
      }

      if (currentMarkerMap.entries.length == patternLength) {
        print(i + 1);
        break;
      }
    }
  }
}
