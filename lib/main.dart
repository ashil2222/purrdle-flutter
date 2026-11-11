import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/home_screen.dart';
import 'view_model/game_view_model.dart';

void main() {
  runApp(const PurrdleApp());
}
// This is the main entry point
class PurrdleApp extends StatelessWidget {
  const PurrdleApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const HomeScreen(),
      ),
    );
  }
}