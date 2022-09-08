import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_impact/components/enemy_projectile.dart';
import 'package:space_impact/components/projectile.dart';
import 'package:space_impact/components/player.dart';
import 'package:space_impact/components/bonus.dart';
import 'package:space_impact/views/screens/game.dart';

class Enemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SpaceImpact> {
  final double _speed = 250;
  late int _type;
  late Timer _timer;

  Enemy({Sprite? sprite, Vector2? position, Vector2? size, int? type})
      : super(sprite: sprite, position: position, size: size) {
    _type = type!;
    anchor = Anchor.center;
    _timer = Timer(0.8, onTick: () {
      _timer.stop();
    });
    add(RectangleHitbox.relative(Vector2(1, 0.45), parentSize: this.size));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(-1, 0) * _speed * dt;
    if (position.x < -size.x / 2) {
      removeFromParent();
    }
    if (_timer.isRunning()) {
      _timer.update(dt);
    }
    if (_type == 1 &&
        !_timer.isRunning() &&
        (position.y - gameRef.player.y).abs() <= gameRef.canvasSize.y / 5 &&
        position.x >= gameRef.player.x) {
      gameRef.add(EnemyProjectile(
          sprite: gameRef.spriteSheet.getSpriteById(6),
          position: position - Vector2(16, 0),
          size: Vector2(64, 64)));
      gameRef.audioService.playSfx("sfx/laser3.mp3");
      _timer.start();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Projectile) {
      removeFromParent();
      _type == 0 ? gameRef.score += 10 : gameRef.score += 20;
      gameRef.updateScore();
      Random random = Random();
      int randomNum = random.nextInt(20);
      if (randomNum == 12 || randomNum == 16) {
        gameRef.add(Bonus(
            sprite: gameRef.spriteSheet.getSpriteById(randomNum == 12 ? 0 : 1),
            size: Vector2(32, 32),
            position: position,
            type: randomNum == 12 ? 1 : 2));
      }
    }
    if (other is Player) {
      removeFromParent();
      gameRef.health -= 1;
      _type == 0 ? gameRef.score += 10 : gameRef.score += 20;
      gameRef.updateScore();
      gameRef.updateHealth();
    }
  }
}
