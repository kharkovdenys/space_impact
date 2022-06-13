import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import '../size_config.dart';

class Player extends SpriteComponent with HasHitboxes, Collidable {
  Vector2 _moveDirection = Vector2.zero();
  final double _speed = 300;

  Player({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size) {
    anchor = Anchor.center;
    addHitbox(HitboxRectangle(relation: Vector2(1,0.45)));
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
