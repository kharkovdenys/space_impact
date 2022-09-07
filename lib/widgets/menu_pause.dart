import 'dart:io';

import 'package:flutter/material.dart';

import '../game.dart';

Widget menuPause(BuildContext buildContext, SpaceImpact game) {
  return SimpleDialog(
    title: const Center(child: Text("Pause")),
    children: <Widget>[
      SimpleDialogOption(
        onPressed: () {
          game.overlays.remove('menuPause');
          game.resumeEngine();
        },
        child: const Center(child: Text('Resume')),
      ),
      SimpleDialogOption(
        onPressed: () {
          game.overlays.remove('menuPause');
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
