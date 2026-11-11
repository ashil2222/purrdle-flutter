import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purrdle/view_model/game_view_model.dart';
import 'package:purrdle/main.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  // Test 1 - max guesses is 6 not 5
  test('max guesses should be 6', () {
    final vm = GameViewModel();
    expect(vm.maxGuesses, equals(6));
  });

  // Test 2 - Duplicate guses is rejected
  test('duplicate guess should be rejected', () async {
    final vm = GameViewModel();
    await vm.loadDictionary();
    vm.submitGuess('crane');
    final result = vm.submitGuess('crane');
    expect(result, isNotNull);
  });

  // Test 3 - Invalid words should be rejected
  test('invalid word should be rejected', () async {
    final vm = GameViewModel();
    await vm.loadDictionary();
    final result = vm.submitGuess('xzxzx');
    expect(result, isNotNull);
  });

  // Test - 4 Guess must be 5 lettets
  test('guess shorter than 5 letters should be rejected', () async {
    final vm = GameViewModel();
    await vm.loadDictionary();
    final result = vm.submitGuess('cat');
    expect(result, isNotNull);
  });

  // Test 5 - Grey is for wrong letters
  test('wrong letter tile color should be grey', () async {
    final vm = GameViewModel();
    await vm.loadDictionary();
    final color = vm.tileColor('zzzzz', 0);
    expect(color, equals(Colors.grey));
  });

  // Test - 6 Home screen show the purrdle title
testWidgets('home screen shows purrdle title', (WidgetTester tester) async {
    await tester.pumpWidget(const PurrdleApp());
    expect(find.text('Purrdle'), findsOneWidget);
    expect(find.textContaining('Guess the hidden five-letter word'),
      findsOneWidget,
    );
    expect(find.byType(Image), findsOneWidget);
    final playButton = find.widgetWithText(ElevatedButton, 'Play Game');
    expect(playButton, findsOneWidget);
  });
}