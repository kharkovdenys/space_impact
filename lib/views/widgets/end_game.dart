import 'dart:io';
import 'package:flutter/material.dart';
import 'package:space_impact/views/screens/game.dart';

Widget endGame(BuildContext buildContext, SpaceImpact game) {
  return SimpleDialog(
    title: Center(child: Text("Your score:${game.score}")),
    children: <Widget>[
      SimpleDialogOption(
        onPressed: () {
          game.overlays.remove('endGame');
          game.restart();
          game.resumeEngine();
        },
        child: const Center(child: Text('Restart')),
      ),
      SimpleDialogOption(
        onPressed: () {
          exit(0);
        },
        child: const Center(child: Text('Exit')),
      ),
    ],
  );
}
