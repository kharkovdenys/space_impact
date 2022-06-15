import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'components/enemy.dart';
import 'components/enemy_projectile.dart';
import 'components/player.dart';
import 'components/projectile.dart';
import 'components/bonus.dart';
import 'components/enemy_generator.dart';
import 'size_config.dart';

class SpaceImpact extends FlameGame with KeyboardEvents, HasCollisionDetection {
  late Player player;
  late SpriteSheet spriteSheet;
  late EnemyGenerator _enemyGenerator;
  late TextComponent _playerScore, _playerHealth, _playerSuperShots;
  late Timer _cooldowns;
  bool _flagFire = false, _flagFireSuper = false;
  int score = 0, health = 3, superShots = 3;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    ParallaxComponent _background = await ParallaxComponent.load(
      [
        ParallaxImageData('background.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(50, 0),
    );
    add(_background);
    await images.load('spritesheet.png');
    spriteSheet = SpriteSheet.fromColumnsAndRows(
        image: images.fromCache('spritesheet.png'), columns: 4, rows: 2);
    player = Player(
        sprite: spriteSheet.getSpriteById(2),
        size: Vector2(64, 64),
        position: Vector2(canvasSize.x / 10, canvasSize.y / 2));
    add(player);
    _enemyGenerator = EnemyGenerator(spriteSheet: spriteSheet);
    add(_enemyGenerator);
    _playerScore = TextComponent(
        text: 'Score: 0',
        position: Vector2(canvasSize.x - 150, 10),
        textRenderer: TextPaint(
            style: TextStyle(color: Colors.white, fontSize: 12.toFont)))
      ..priority = 1;
    _playerHealth = TextComponent(
        text: '❤❤❤',
        position: Vector2(10, 0),
        textRenderer: TextPaint(
            style: TextStyle(color: Colors.white, fontSize: 24.toFont)))
      ..priority = 1;
    _playerSuperShots = TextComponent(
        text: 'Super Shots: $superShots/10',
        position: Vector2(canvasSize.x - 400, 10),
        textRenderer: TextPaint(
            style: TextStyle(color: Colors.white, fontSize: 12.toFont)))
      ..priority = 1;
    _playerSuperShots.positionType = PositionType.viewport;
    _playerHealth.positionType = PositionType.viewport;
    _playerScore.positionType = PositionType.viewport;
    add(_playerScore);
    add(_playerHealth);
    add(_playerSuperShots);
    _cooldowns = Timer(0.4, onTick: () {
      _cooldowns.stop();
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_cooldowns.isRunning()) {
      _cooldowns.update(dt);
    }
    if (_flagFireSuper && superShots > 0 && !_cooldowns.isRunning()) {
      Projectile projectile = Projectile(
        sprite: spriteSheet.getSpriteById(7),
        size: Vector2(64, 64),
        position: player.position + Vector2(16, 0),
      );
      add(projectile);
      superShots--;
      updateSuperShots();
      _cooldowns.start();
    }
    if (_flagFire && !_cooldowns.isRunning()) {
      Projectile projectile = Projectile(
          sprite: spriteSheet.getSpriteById(4),
          size: Vector2(64, 64),
          position: player.position + Vector2(16, 0),
          type: 1);
      add(projectile);
      _cooldowns.start();
    }
  }

  void updateScore() {
    _playerScore.text = 'Score: $score';
  }

  void updateSuperShots() {
    _playerSuperShots.text = 'Super Shots: $superShots/10';
  }

  void updateHealth() {
    _playerHealth.text = '';
    if (health <= 0) {
      paused = true;
      overlays.add('endGame');
    } else {
      for (int i = 1; i <= health; i++) {
        _playerHealth.text += '❤';
      }
    }
  }

  void restart() {
    _flagFire = false;
    _flagFireSuper = false;
    score = 0;
    health = 3;
    superShots = 3;
    player.position = Vector2(canvasSize.x / 10, canvasSize.y / 2);
    children.whereType<Enemy>().forEach((enemy) {
      enemy.removeFromParent();
    });
    children.whereType<Projectile>().forEach((projectile) {
      projectile.removeFromParent();
    });
    children.whereType<Bonus>().forEach((bonus) {
      bonus.removeFromParent();
    });
    children.whereType<EnemyProjectile>().forEach((enemyProjectile) {
      enemyProjectile.removeFromParent();
    });
    updateHealth();
    updateScore();
    updateSuperShots();
  }

  @override
  onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.escape) && !paused) {
      overlays.add('menuPause');
      pauseEngine();
    }
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      _flagFire = true;
    } else {
      _flagFire = false;
    }
    if (keysPressed.contains(LogicalKeyboardKey.tab)) {
      _flagFireSuper = true;
    } else {
      _flagFireSuper = false;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
        keysPressed.contains(LogicalKeyboardKey.keyW) &&
        !keysPressed.contains(LogicalKeyboardKey.keyS)) {
      player.setMoveDirection(Vector2(7.071, -7.071));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      player.setMoveDirection(Vector2(7.071, 7.071));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      player.setMoveDirection(Vector2(-7.071, 7.071));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      player.setMoveDirection(Vector2(-7.071, -7.071));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      player.setMoveDirection(Vector2(10, 0));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      player.setMoveDirection(Vector2(0, 10));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      player.setMoveDirection(Vector2(-10, 0));
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      player.setMoveDirection(Vector2(0, -10));
    } else {
      player.setMoveDirection(Vector2(0, 0));
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    gameSize = canvasSize;
  }
}
