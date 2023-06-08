import 'package:flutter/material.dart';
import 'package:text_twist_flutter/bloc/game_bloc.dart';

class GamePage extends StatefulWidget {
  final GameBloc gameBloc;

  const GamePage({
    Key? key,
    required this.gameBloc,
    required int currentLevel,
    required String shuffledWord,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    String guess = _textEditingController.text;
    bool isCorrect = widget.gameBloc.checkGuess(guess);
    _textEditingController.clear();
    if (isCorrect) {
      widget.gameBloc.nextWord();
      if (widget.gameBloc.currentWordIndex == 0) {
        widget.gameBloc.nextLevel();
      }
      _showSnackBar('You guessed it correctly!', Colors.green);
    } else {
      _showSnackBar('You guessed it wrong!', Colors.red);
    }
    setState(() {
      // Update the shuffled word
      widget.gameBloc.updateShuffledWord();
    });
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget buildLetterContainer(String letter, bool isGuessed) {
    Color textColor = Colors.white;
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF5271FF),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w400,
            height: 26 / 21.6315,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String shuffledWord = widget.gameBloc.shuffledWord;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Level ${widget.gameBloc.currentLevelIndex + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5271FF),
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 100.0),
                  const Text(
                    'Guess the words',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5271FF),
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: shuffledWord.split('').map((letter) {
                      bool isGuessed = widget.gameBloc.checkGuess(letter);
                      return buildLetterContainer(letter, isGuessed);
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your guess',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _checkAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF1A9C37), // Set the button color to green
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
