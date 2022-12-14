import 'dart:io';

class Tree {
  final int height;
  final bool isEdgeTree;
  final int rowIndex;
  final int columnIndex;

  List<int> neighboringUpTrees = [];
  List<int> neighboringLeftTrees = [];
  List<int> neighboringRightTrees = [];
  List<int> neighboringDownTrees = [];

  Tree(
      {required this.height,
      required this.isEdgeTree,
      required this.rowIndex,
      required this.columnIndex});

  bool get isVisible =>
      isEdgeTree ||
      neighboringUpTrees.reduce((curr, next) => curr > next ? curr : next) <
          this.height ||
      neighboringLeftTrees.reduce((curr, next) => curr > next ? curr : next) <
          this.height ||
      neighboringRightTrees.reduce((curr, next) => curr > next ? curr : next) <
          this.height ||
      neighboringDownTrees.reduce((curr, next) => curr > next ? curr : next) <
          this.height;

  int get positionScore {
    if (isEdgeTree) return 0;
    int partialUpScore = 0;
    int partialDownScore = 0;
    int partialLeftScore = 0;
    int partialRightScore = 0;
    for (int i = 0; i < neighboringUpTrees.length; i++) {
      if (neighboringUpTrees[i] < this.height) {
        partialUpScore++;
        continue;
      }
      partialUpScore++;
      break;
    }
    for (int i = 0; i < neighboringDownTrees.length; i++) {
      if (neighboringDownTrees[i] < this.height) {
        partialDownScore++;
        continue;
      }
      partialDownScore++;

      break;
    }
    for (int i = 0; i < neighboringLeftTrees.length; i++) {
      if (neighboringLeftTrees[i] < this.height) {
        partialLeftScore++;
        continue;
      }
      partialLeftScore++;
      break;
    }
    for (int i = 0; i < neighboringRightTrees.length; i++) {
      if (neighboringRightTrees[i] < this.height) {
        partialRightScore++;
        continue;
      }
      partialRightScore++;
      break;
    }
    return partialUpScore *
        partialLeftScore *
        partialRightScore *
        partialDownScore;
  }

  @override
  String toString() {
    return this.isVisible.toString();
  }
}

void main(List<String> args) {
  File file = new File('C:/Users/thiag/Desktop/aoc2022/day8/dart/input.txt');

  List<String> lines = file.readAsLinesSync();

  List<List<Tree>> treeSquare = [];

  _populateTreeSquare(lines, treeSquare);

  _calculateTreeNeighborhood(treeSquare, lines);

  _solvePart1(treeSquare);

  _solvePart2(treeSquare);
}

void _solvePart2(List<List<Tree>> treeSquare) {
  int maxScore = 0;
  for (List<Tree> trees in treeSquare) {
    for (Tree tree in trees) {
      final int positionScore = tree.positionScore;
      if (positionScore > maxScore) {
        maxScore = positionScore;
      }
    }
  }

  print('Part2: $maxScore');
}

void _solvePart1(List<List<Tree>> treeSquare) {
  int visibleCount = 0;

  for (List<Tree> trees in treeSquare) {
    for (Tree tree in trees) {
      if (tree.isVisible) visibleCount++;
    }
  }

  print('Part1: $visibleCount');
}

void _calculateTreeNeighborhood(
    List<List<Tree>> treeSquare, List<String> lines) {
  for (int i = 0; i < treeSquare.length; i++) {
    for (int j = 0; j < treeSquare[i].length; j++) {
      final currentTree = treeSquare[i][j];
      if (!currentTree.isEdgeTree) {
        currentTree.neighboringRightTrees.addAll(
          treeSquare[i]
              .where((e) => e.columnIndex > currentTree.columnIndex)
              .map((e) => e.height)
              .toList(),
        );
        currentTree.neighboringLeftTrees.addAll(
          treeSquare[i]
              .where((e) => e.columnIndex < currentTree.columnIndex)
              .map((e) => e.height)
              .toList()
              .reversed,
        );

        for (int k = currentTree.rowIndex; k < lines.length; k++) {
          if (currentTree.rowIndex == k)
            continue;
          else {
            currentTree.neighboringDownTrees.add(treeSquare[k][j].height);
          }
        }
        for (int k = currentTree.rowIndex; k > -1; k--) {
          if (currentTree.rowIndex == k)
            continue;
          else {
            currentTree.neighboringUpTrees.add(treeSquare[k][j].height);
          }
        }
      }
    }
  }
}

void _populateTreeSquare(List<String> lines, List<List<Tree>> treeSquare) {
  for (int i = 0; i < lines.length; i++) {
    treeSquare.add([]);
    for (int j = 0; j < lines[i].length; j++) {
      if (i == 0 ||
          i == lines.length - 1 ||
          j == 0 ||
          j == lines[i].length - 1) {
        treeSquare[i].add(
          Tree(
            height: int.parse(lines[i][j]),
            isEdgeTree: true,
            columnIndex: j,
            rowIndex: i,
          ),
        );
      } else {
        treeSquare[i].add(
          Tree(
            height: int.parse(lines[i][j]),
            isEdgeTree: false,
            columnIndex: j,
            rowIndex: i,
          ),
        );
      }
    }
  }
}
