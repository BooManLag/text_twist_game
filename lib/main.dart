import 'package:event_bloc/event_bloc.dart';
import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:text_twist_flutter/bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:text_twist_flutter/widgets/main_menu.dart';

void main() {
  runApp(
    BlocProvider<GameBloc>(
      create: (context, channel) => GameBloc(channel, parentChannel: channel),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameBloc = BlocProvider.watch<GameBloc>(context);
    return MaterialApp(
      home: MainMenuPage(gameBloc: gameBloc),
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF5271FF, {
          50: Color(0xFFE8EAFF),
          100: Color(0xFFC6CBFF),
          200: Color(0xFFA0A9FF),
          300: Color(0xFF7A87FF),
          400: Color(0xFF5F6DFF),
          500: Color(0xFF5271FF),
          600: Color(0xFF4967FF),
          700: Color(0xFF3E5DFF),
          800: Color(0xFF3452FF),
          900: Color(0xFF253FFF),
        }),
      ),
    );
  }
}
