import 'dart:math';
import 'package:event_bloc/event_bloc.dart';
import 'package:text_twist_flutter/models/level.dart';
import 'package:text_twist_flutter/models/word.dart';

class GameBloc extends Bloc {
  final List<Level> levels = [
    Level([
      Word('cat'),
      Word('dog'),
      Word('sun'),
      Word('pen'),
      Word('cup'),
    ]),
    Level([
      Word('tree'),
      Word('book'),
      Word('bird'),
      Word('fish'),
      Word('rose'),
    ]),
    Level([
      Word('cake'),
      Word('juice'),
      Word('chair'),
      Word('lamp'),
      Word('clock'),
    ]),
    Level([
      Word('guitar'),
      Word('banana'),
      Word('orange'),
      Word('pizza'),
      Word('shirt'),
    ]),
    Level([
      Word('elephant'),
      Word('computer'),
      Word('pencil'),
      Word('glasses'),
      Word('shampoo'),
    ]),
    // Add more levels here...
  ];
  int currentLevelIndex = 0;
  int currentWordIndex = 0;
  Random random = Random();
  late String shuffledWord;

  GameBloc(BlocEventChannel? channel, {required super.parentChannel}) {
    updateShuffledWord();
  }

  Level get currentLevel => levels[currentLevelIndex];
  Word get currentWord => currentLevel.words[currentWordIndex];

  void nextWord() {
    if (currentWordIndex < currentLevel.words.length - 1) {
      currentWordIndex++;
    } else {
      nextLevel();
    }
    updateShuffledWord();
  }

  void nextLevel() {
    if (currentLevelIndex < levels.length - 1) {
      currentLevelIndex++;
      currentWordIndex = 0;
    } else {
      // The game is over
    }
    updateShuffledWord();
  }

  bool checkGuess(String guess) {
    if (guess == currentWord.word) {
      currentWord.isGuessed = true;
      return true;
    }
    return false;
  }

  void setLevel(int level) {
    currentLevelIndex = level;
    currentWordIndex = 0;
    updateShuffledWord();
  }

  void updateShuffledWord() {
    shuffledWord = _shuffleWord(currentWord.word);
  }

  String _shuffleWord(String word) {
    List<String> characters = word.split('');
    characters.shuffle(random);
    return characters.join();
  }
}
