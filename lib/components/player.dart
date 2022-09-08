import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_impact/services/size_config.dart';

class Player extends SpriteComponent with CollisionCallbacks {
  Vector2 _moveDirection = Vector2.zero();
  final double _speed = 300;

  Player({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size) {
    anchor = Anchor.center;
    add(RectangleHitbox.relative(Vector2(1, 0.45), parentSize: this.size));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * _speed * dt;
    position.clamp(size / 2, gameSize - size / 2);
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }
}
