import 'package:flutter/material.dart';
import '../widgets/purrdle_text.dart';
import 'game_screen.dart';


// This shows the cat image, title, and play button
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(
            child: Text(
              'Purrdle',
              style: TextStyle(
                fontFamily: 'Courier',
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 48.0,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/title.png',
              width: 200,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: PurrdleText(
                'Guess the hidden five-letter word in just six Meows '
                '(tries)! After each guess, tiles will light up, green '
                'means the letter is IN the right spot, yellow means '
                'the letter IS in the word but in the wrong spot, and '
                'grey means the letter IS not in the word at all.',
                size: 14.0,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameScreen(),
                  ),
                );
              },
              child: const Text(
                'Play Game',
                style: TextStyle(
                  fontFamily: 'Courier',
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}