import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_twist_flutter/bloc/game_bloc.dart';

import 'credits.dart';
import 'level_display.dart';

class MainMenuPage extends StatelessWidget {
  final GameBloc gameBloc;

  const MainMenuPage({Key? key, required this.gameBloc}) : super(key: key);

  ElevatedButton buildElevatedButton(String text, VoidCallback onPressed) {
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
      onPressed: onPressed,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/WTMenu.png"),
            const SizedBox(height: 70),
            buildElevatedButton('Start', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LevelDisplay(gameBloc: gameBloc),
                ),
              );
            }),
            buildElevatedButton('Credits', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreditsPage(),
                ),
              );
            }),
            buildElevatedButton('Exit', () {
              // Exit the app
              SystemNavigator.pop();
            }),
          ],
        ),
      ),
    );
  }
}
