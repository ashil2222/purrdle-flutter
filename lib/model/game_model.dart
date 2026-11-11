import 'package:flutter/material.dart';
// In this place class holds the game data and no logic here
class GameModel {
  String targetWord;
  List<String> guesses;
  int maxGuesses;
  Map<String, Color> keyboardColors;

  GameModel ({
    this.targetWord = '',
    List<String>? guesses,
    // I fix this 5 to 6 
    this.maxGuesses = 6,
    Map<String, Color>? keyboardColors,
 })   :guesses = guesses ?? [],
       keyboardColors = keyboardColors ??
    {
      for (var c in 'QWERTYUIOPASDFGHJKLZXCVBNM'.split(''))
        c: Colors.grey.shade300,

    };
  void reset(String newTarget) {
    targetWord = newTarget;
    guesses.clear();
    keyboardColors = {
      for (var c in 'QWERTYUIOPASDFGHJKLZXCVBNM'.split(''))
        c: Colors.grey.shade300,
    };
  }
}