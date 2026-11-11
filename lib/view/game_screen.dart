import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/game_view_model.dart';
import 'stats_screen.dart';
// I have kept the UI structure as original
// This has the game screen and view only

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}
class _GameScreenState extends State<GameScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<GameViewModel>().loadDictionary();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showWinPopup(BuildContext context, GameViewModel vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              ':D',
              style: TextStyle(
                fontSize: 64,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Meow! You guessed it!\nThe word was: ${vm.targetWord.toUpperCase()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 20,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Reset the Game
              vm.resetGame();
              _controller.clear();
            },
            child: const Text(
              'Close',
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 32,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _showLosePopup(BuildContext context, GameViewModel vm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              ':(',
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 64,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'The word was: ${vm.targetWord.toUpperCase()}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              vm.resetGame();
              _controller.clear();
            },
            child: const Text(
              'Close',
              style: TextStyle(
                fontFamily: 'Courier',
                color: Colors.pink,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
// Handles when the player press the submit
  void _handleSubmit(BuildContext context, GameViewModel vm) {
    final error = vm.submitGuess(_controller.text);
    _controller.clear();

    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    if (vm.guesses.last == vm.targetWord) {
      _showWinPopup(context, vm);
    } else if (vm.guesses.length >= vm.maxGuesses) {
      _showLosePopup(context, vm);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GameViewModel>();

    if (vm.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: Colors.pink),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StatsScreen()),
                    );
                  },
                  icon: const Icon(Icons.bar_chart, color: Colors.pink),
                  label: const Text(
                    'Stats',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (rowIndex) {
                final guess = rowIndex < vm.guesses.length
                    ? vm.guesses[rowIndex]
                    : null;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (colIndex) {
                    String letter = '';
                    Color bgColor = Colors.grey.shade300;
                    if (guess != null && colIndex < guess.length) {
                      letter = guess[colIndex].toUpperCase();
                      bgColor = vm.tileColor(guess, colIndex);
                    }
                    return Container(
                      margin: const EdgeInsets.all(4.0),
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              onSubmitted: (_) => _handleSubmit(context, vm),
              maxLength: 5,
              maxLines: 1,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your guess',
                counterText: '',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _handleSubmit(context, vm),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    vm.resetGame();
                    _controller.clear();
                  },
                  child: const Text(
                    'New Game',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildKeyboard(vm),
          ],
        ),
      ),
    );
  }
  Widget _buildKeyboard(GameViewModel vm) {
    const rows = ['QWERTYUIOP', 'ASDFGHJKL', 'ZXCVBNM'];
    return Column(
      children: rows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.split('').map((letter) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              width: 30,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: vm.keyboardColors[letter],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black26),
              ),
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}