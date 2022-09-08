import 'package:space_impact/views/widgets/button_pause.dart';
import 'package:space_impact/views/widgets/end_game.dart';
import 'package:space_impact/views/widgets/menu_pause.dart';
import 'package:space_impact/views/screens/game.dart';
import 'package:space_impact/services/size_config.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game title.
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0.toHeight),
                child: Text(
                  'Space Impact',
                  style: TextStyle(color: Colors.white, fontSize: 72.toFont),
                ),
              ),
              SizedBox(
                width: SizeConfig.screenWidth! / 8,
                height: SizeConfig.screenWidth! / 8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => GameWidget(
                          game: SpaceImpact(),
                          overlayBuilderMap: const {
                            'buttonPause': buttonPause,
                            'menuPause': menuPause,
                            'endGame': endGame
                          },
                          initialActiveOverlays: const ['buttonPause'],
                        ),
                      ),
                    );
                  },
                  child: Center(child: Image.asset('assets/images/play.jpg')),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
