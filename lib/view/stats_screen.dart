import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/game_view_model.dart';
import '../widgets/purrdle_text.dart';

// Shows wins, losses, win rate and total guesses
class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GameViewModel>();
    final totalGames = vm.wins + vm.losses;
    final winRate = totalGames == 0
        ? 0
        : ((vm.wins / totalGames) * 100).round();
        return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.pink),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Statistics',
          style: TextStyle(
            fontFamily: 'Courier',
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PurrdleText('Your Purrdle Stats', size: 22),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statTile('Games\nPlayed', '$totalGames'),
                  _statTile('Wins', '${vm.wins}'),
                  _statTile('Losses', '${vm.losses}'),
                  _statTile('Win Rate', '$winRate%'),
                ],
              ),
              const SizedBox(height: 32),

              _statTile('Total\nGuesses', '${vm.totalGuesses}'),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Back to Game',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _statTile(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}