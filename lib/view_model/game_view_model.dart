import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../model/game_model.dart';

// ViewModel Connects the Model and the View
// All Game Logic stay here
class GameViewModel extends ChangeNotifier {
  final GameModel _model = GameModel();
  late List<String> _dictionary;
  bool _isLoading = true;
  String get targetWord => _model.targetWord;
  List<String> get guesses => List.unmodifiable(_model.guesses);
  int get maxGuesses => _model.maxGuesses;
  Map<String, Color> get keyboardColors => Map.unmodifiable(_model.keyboardColors);
  bool get isLoading => _isLoading;

  int _wins = 0;
  int _losses = 0;
  int _totalGuesses = 0;
  int get wins => _wins;
  int get losses => _losses;
  int get totalGuesses => _totalGuesses;

  Future<void> loadDictionary() async {
    final raw = await rootBundle.loadString('assets/english_dict.txt');
    _dictionary = raw
    .split('\n')
    .map((w) => w.trim().toLowerCase())
    .where((w) => w.length == 5)
    .toList();
    _model.targetWord =
    _dictionary[Random().nextInt(_dictionary.length)];
    _isLoading = false;
    notifyListeners();
  }
  // Bug fix - I hanged red to grey for ltters mot in the word
  Color tileColor(String guess, int index) {
    if (_model.targetWord[index] == guess[index]) {
      return Colors.green;
    } else if (_model.targetWord.contains(guess[index])) {
      return Colors.yellow;
    } else {
      return Colors.grey; // BUG FIX - Before thecolor ws red
    }
  }

  String? submitGuess(String rawInput) {
    final guess = rawInput.trim().toLowerCase();
    if (guess.length != 5) return 'Meow! Guess must be 5 letters.';
    if (!_dictionary.contains(guess)) return 'Meow, not a valid word!';
    // Bug fix - stoped duplicate guesses
    if (_model.guesses.contains(guess)) {
      return 'Meow! You already tried that word.';
    }
    _model.guesses.add(guess);
    _totalGuesses++;
    _updateKeyboardColors(guess);
    if (guess == _model.targetWord) {
      _wins++;
    } else if (_model.guesses.length >= _model.maxGuesses) {
      _losses++;
    }
    notifyListeners();
    return null;
  }
  void resetGame() {
    _model.reset(_dictionary[Random().nextInt(_dictionary.length)]);
    notifyListeners();
  }
// This updates the keyborad colors after each guess
  void _updateKeyboardColors(String guess) {
    for (int i = 0; i < guess.length; i++) {
      final letter = guess[i].toUpperCase();
      final newColor = tileColor(guess, i);
      final current = _model.keyboardColors[letter];
      if (current == Colors.green) continue;
      if (current == Colors.yellow && newColor == Colors.grey) continue;
      _model.keyboardColors[letter] = newColor;
    }
  }
}