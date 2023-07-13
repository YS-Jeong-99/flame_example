// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';

import '../doodle_dash.dart';

// It won't be a detailed section of the codelab, as its not Flame specific
class LevelManager extends Component with HasGameRef<DoodleDash> {
  LevelManager({this.selectedLevel = 1, this.level = 1});

  int selectedLevel; // level that the player selects at the beginning
  int level; // current level
  // Configurations for different levels of difficulty,
  //the higher level the further away Dash may need to jump. Since
  // gravity is constant, jumpSpeed needs to accomodate for further distance.
  // Score indicates the score needed to be acheived to "level up"
  final Map<int, Difficulty> levelsConfig = {
    1: const Difficulty(
        gravity: 8.0, score: 0),
    2: const Difficulty(
        gravity: 8.5, score: 20),
    3: const Difficulty(
        gravity: 9, score: 40),
    4: const Difficulty(
        gravity: 10, score: 80),
    5: const Difficulty(
        gravity: 11, score: 100),
  };

  double get startingGravity {
    return levelsConfig[selectedLevel]!.gravity;
  }

  double get gravity {
    return levelsConfig[level]!.gravity;
  }

  Difficulty get difficulty {
    return levelsConfig[level]!;
  }

  bool shouldLevelUp(int score) {
    int nextLevel = level + 1;

    if (levelsConfig.containsKey(nextLevel)) {
      return levelsConfig[nextLevel]!.score == score;
    }

    return false;
  }

  List<int> get levels {
    return levelsConfig.keys.toList();
  }

  void increaseLevel() {
    if (level < levelsConfig.keys.length) {
      level++;
    }
  }

  void setLevel(int newLevel) {
    if (levelsConfig.containsKey(newLevel)) {
      level = newLevel;
    }
  }

  void selectLevel(int selectLevel) {
    if (levelsConfig.containsKey(selectLevel)) {
      selectedLevel = selectLevel;
    }
  }

  void reset() {
    level = selectedLevel;
  }
}

class Difficulty {
  final double gravity;
  final int score;

  const Difficulty(
      {required this.gravity,
      required this.score});
}
