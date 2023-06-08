import 'package:flutter/material.dart';
import 'package:text_twist_flutter/bloc/game_bloc.dart';
import 'package:text_twist_flutter/widgets/game_page.dart';

class LevelDisplay extends StatelessWidget {
  final GameBloc gameBloc;

  const LevelDisplay({Key? key, required this.gameBloc}) : super(key: key);

  ElevatedButton buildElevatedButton(int level, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF5271FF),
        fixedSize: const Size(130, 30),
        textStyle: const TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w500,
          fontSize: 21.6315,
          height: 26 / 21.6315,
        ),
      ),
      onPressed: () {
        gameBloc.setLevel(level - 1); // Set the desired level in the GameBloc
        final shuffledWord = gameBloc.shuffledWord;
        final currentLevel = gameBloc.currentLevelIndex + 1;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(
              shuffledWord: shuffledWord,
              currentLevel: currentLevel,
              gameBloc: gameBloc,
            ),
          ),
        );
      },
      child: Text('Level $level'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Level',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Color(0xFF5271FF)),
            ),
            const SizedBox(height: 30.0),
            buildElevatedButton(1, context),
            buildElevatedButton(2, context),
            buildElevatedButton(3, context),
            buildElevatedButton(4, context),
            buildElevatedButton(5, context),
          ],
        ),
      ),
    );
  }
}
