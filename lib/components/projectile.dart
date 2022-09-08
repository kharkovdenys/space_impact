import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_impact/components/enemy_projectile.dart';
import 'package:space_impact/components/enemy.dart';
import 'package:space_impact/services/size_config.dart';

class Projectile extends SpriteComponent with CollisionCallbacks {
  final double _speed = 500;
  late int _type;

  Projectile({Sprite? sprite, Vector2? position, Vector2? size, int? type})
      : super(sprite: sprite, position: position, size: size) {
    _type = type ?? 0;
    anchor = Anchor.center;
    add(RectangleHitbox.relative(
      Vector2(0.625, 0.125),
      parentSize: this.size,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(1, 0) * _speed * dt;
    if (position.x > gameSize.x + size.x / 2) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy || other is EnemyProjectile) {
      if (_type == 1) {
        removeFromParent();
      }
    }
  }
}
