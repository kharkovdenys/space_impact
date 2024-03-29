import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:space_impact/components/enemy.dart';
import 'package:space_impact/views/screens/game.dart';
import 'package:space_impact/services/size_config.dart';

class EnemyGenerator extends Component with HasGameRef<SpaceImpact> {
  Random random = Random();
  late Timer timer;
  SpriteSheet spriteSheet;

  EnemyGenerator({required this.spriteSheet}) : super() {
    timer = Timer(1, onTick: generation, repeat: true);
  }

  void generation() {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(
        gameSize.x + initialSize.x * 2, gameSize.y * random.nextDouble());
    position.clamp(
      initialSize / 2,
      gameSize - initialSize / 2,
    );
    int type = random.nextInt(2);
    Enemy enemy = Enemy(
        sprite: spriteSheet.getSpriteById(type == 0 ? 3 : 5),
        size: initialSize,
        position: position,
        type: type)
      ..priority = 0;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }
}
