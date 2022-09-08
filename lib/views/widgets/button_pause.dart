import 'package:flutter/material.dart';
import 'package:space_impact/services/size_config.dart';
import 'package:space_impact/views/screens/game.dart';

Widget buttonPause(BuildContext buildContext, SpaceImpact game) {
  return Align(
    alignment: Alignment.topCenter,
    child: TextButton(
      child: Icon(
        Icons.pause_rounded,
        color: Colors.white,
        size: 48.toFont,
      ),
      onPressed: () {
        if (!game.paused) {
          game.overlays.add('menuPause');
          game.pauseEngine();
        }
      },
    ),
  );
}
