# Master Code Quiz

Master Code Quiz is a quiz application developed in Flutter that allows users to test their knowledge in various programming languages. The app provides quizzes in Python, Java, C++, Dart, Android, HTML, SQL, and JavaScript.

## Features

- Display available quizzes for each programming language.
- Customize the number of questions in a quiz.
- Verify answers and display results.
- Save scores and keep a history of completed quizzes.
- Delete quiz results.
- Translate the application content from Creole to English using the Easy Localization package.

## Technologies Used

- Flutter
- Dart programming language

## Project Structure

The project follows the following structure:

- `lib`: Contains the main source code files.
  - `main.dart`: Entry point of the application that launches the app's material design.
  - `model`: Contains the models used in the application.
  - `service`: Contains service files.
    - `service_json.dart`: Handles reading quiz data from JSON files.
    - `service_sharepreferences.dart`: Manages storing quiz results using shared preferences.
  - `screens`: Contains the screens of the application.
    - `quiz_screen.dart`: Displays the available quizzes and allows users to customize the quiz settings.
    - `activity_screen.dart`: Shows the scores and history of completed quizzes.
  - `widgets`: Contains reusable widgets used throughout the application.

## Getting Started

To get started with the project, follow these steps:

1. Clone the GitHub repository:
git clone https://github.com/Djeevs-Jean/flutter_quiz_app.git


2. Install the required dependencies:
flutter pub get


3. Run the application on an emulator or physical device:
flutter run


## Contributing

Contributions to the project are welcome. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

[MIT License](LICENSE)

## Credits

- This project uses the following third-party libraries:
- Easy Localization: [https://pub.dev/packages/easy_localization](https://pub.dev/packages/easy_localization)

