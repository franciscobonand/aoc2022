import 'dart:io';

class Directory {
  List<String> directories = [];
  List<int> files = [];
  int totalSize = 0;
  bool calculated = false;
  String name;
  Directory(
    this.name,
  );
}

void main(List<String> args) {
  File file = new File('input.txt');

  List<String> lines = file.readAsLinesSync();

  Map<String, Directory> directories = {};

  String currentPath = '';

  _computeCommands(lines, currentPath, directories);

  _calculateDirectoriesSizes(directories);

  _solvePart1(directories);
  _solvePart2(directories);
}

void _solvePart2(Map<String, Directory> directories) {
  final int filesystemSize = 70000000;
  final int neededSpace = 30000000;

  int usedSpace = directories['/']!.totalSize;

  final int freeSpace = filesystemSize - usedSpace;
  final int spaceToClean = neededSpace - freeSpace;

  int smallestDirectoryToCleanSize = filesystemSize;

  for (var entrie in directories.entries) {
    final int directorySize = entrie.value.totalSize;
    if (directorySize > spaceToClean &&
        directorySize < smallestDirectoryToCleanSize) {
      smallestDirectoryToCleanSize = directorySize;
    }
  }

  print('Part2 $smallestDirectoryToCleanSize');
}

void _solvePart1(Map<String, Directory> directories) {
  int sum = 0;
  for (var entrie in directories.entries) {
    if (entrie.value.totalSize < 100000) {
      sum += entrie.value.totalSize;
    }
  }

  print('Part1 $sum');
}

void _calculateDirectoriesSizes(Map<String, Directory> directories) {
  while (true) {
    List<MapEntry<String, Directory>> nodes = directories.entries
        .where((element) =>
            element.value.directories.length == 0 &&
            element.value.calculated == false)
        .toList();

    if (nodes.length == 0) break;

    for (var node in nodes) {
      if (node.value.files.isNotEmpty) {
        node.value.totalSize += node.value.files.reduce((f, s) => f + s);
      }
      node.value.calculated = true;

      for (var entrie in directories.entries) {
        if (entrie.value.directories.contains(node.value.name)) {
          entrie.value.totalSize += node.value.totalSize;
          entrie.value.directories.remove(node.value.name);
        }
      }
    }
  }
}

void _computeCommands(List<String> lines, String currentPath,
    Map<String, Directory> directories) {
  for (int currentLineIndex = 0;
      currentLineIndex < lines.length;
      currentLineIndex++) {
    final command = lines[currentLineIndex].split(' ')[1];
    switch (command) {
      case 'cd':
        final destiny = lines[currentLineIndex].split(' ')[2];
        if (destiny == '..') {
          currentPath = currentPath.substring(0, currentPath.lastIndexOf('/'));
          if (currentPath.isEmpty) currentPath = '/';
        } else if (destiny == '/') {
          currentPath = '/';
        } else {
          if (currentPath == '/') {
            currentPath += '$destiny';
          } else {
            currentPath += '/$destiny';
          }
        }
        break;
      case 'ls':
        for (int i = currentLineIndex + 1; i < lines.length; i++) {
          if (lines[i][0] != '\$') {
            currentLineIndex++;
            if (lines[i].split(' ')[0] == 'dir') {
              final pathToBeAdded =
                  currentPath == '/' ? currentPath : currentPath + '/';
              if (directories.containsKey(currentPath)) {
                directories[currentPath]!
                    .directories
                    .add(pathToBeAdded + lines[i].split(' ')[1]);
              } else {
                directories[currentPath] = Directory(currentPath)
                  ..directories.add(pathToBeAdded + lines[i].split(' ')[1]);
              }
            } else {
              if (directories.containsKey(currentPath)) {
                directories[currentPath]!
                    .files
                    .add(int.parse(lines[i].split(' ')[0]));
              } else {
                directories[currentPath] = Directory(currentPath)
                  ..files.add(int.parse(lines[i].split(' ')[0]));
              }
            }
          } else {
            break;
          }
        }
        break;
      default:
    }
  }
}
