# 🐱 Purrdle — Flutter Word Puzzle Game

**Purrdle** is a Wordle-inspired word guessing game developed with **Flutter** and **Dart**. Players have six attempts to guess a hidden five-letter English word, receiving color-coded feedback after each guess.

This project was completed as part of university coursework, focusing on **debugging, refactoring, state management, and feature development** in an existing application.

## ✨ Features

- **Six attempts** to guess the five-letter word.
- **Color-coded hints:** green for the correct letter in the correct position, yellow for a letter in the wrong position, and grey for a letter not in the target word.
- **On-screen keyboard** that updates its letter colors based on previous guesses.
- **Dictionary validation** to reject invalid guesses.
- **Duplicate guess prevention** so the same word cannot be submitted twice.
- **Statistics screen** displaying wins, losses, win rate, and total guesses.
- **New-game option** to play again with another word.

> **Note:** Statistics are stored in app memory, so they reset when the app restarts. Persistent storage is not implemented.

## 🛠️ Technologies

| Technology | Purpose |
| --- | --- |
| Flutter | Application user interface |
| Dart | Application programming language |
| Provider + ChangeNotifier | State management and UI updates |
| MVVM | Separation of models, game logic, and views |

## 🧩 Architecture

The codebase follows the **Model–View–ViewModel (MVVM)** pattern to keep gameplay logic separate from UI components.

```text
lib/
├── main.dart
├── model/
│   └── game_model.dart
├── view_model/
│   └── game_view_model.dart
├── view/
│   ├── home_screen.dart
│   ├── game_screen.dart
│   └── stats_screen.dart
└── widgets/
    └── purrdle_text.dart

assets/
├── english_dict.txt
└── title.png
```

- **Model:** Stores the target word, player guesses, guess limit, and keyboard colors.
- **ViewModel:** Handles dictionary loading, guess validation, game logic, statistics, and state notifications.
- **View:** Displays the home, gameplay, and statistics screens.
- **Widgets:** Contains reusable interface components.

## 🔧 My Contributions

I worked on improving an existing version of Purrdle rather than building the original application from scratch.

### Bug fixes
- Corrected the maximum number of guesses from **five to six**.
- Changed feedback for letters not in the target word from **red to grey**.
- Added validation to **reject repeated guesses**.
- Removed unused imports and corrected package references in the widget test file.

### Refactoring
- Reorganized the application into **Model, View, ViewModel, and Widgets** folders.
- Moved gameplay logic out of the UI layer into a `GameViewModel` using `ChangeNotifier`.
- Used **Provider** to connect application state with the interface.
- Extracted reusable components and separated the home screen from the app entry point.

### New feature
- Added a **statistics screen** that displays wins, losses, win rate, and total guesses during the current app session.

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured
- A Flutter-compatible editor, such as VS Code or Android Studio
- A configured supported device or web browser

### Run the project

1. Clone the repository:

   ```bash
   git clone https://github.com/YOUR-USERNAME/purrdle-flutter.git
   ```

2. Open the project folder:

   ```bash
   cd purrdle-flutter
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run -d chrome
   ```

   Or use `flutter run` to select another configured target.

> This repository includes the Flutter **web** platform files. Additional platform folders may need to be generated to run on other platforms.

## 📚 What I Learned

This project helped me gain practical experience with:

- Debugging an existing Flutter application against functional requirements.
- Applying MVVM to make code easier to understand and maintain.
- Managing reactive application state with Provider and `ChangeNotifier`.
- Implementing gameplay validation and a new user-facing feature.
- Organizing a Flutter codebase into reusable, focused components.

## 📄 Project Context

**Type:** University coursework / Flutter application improvement project  
**Focus:** Bug fixes · MVVM refactoring · Statistics feature
