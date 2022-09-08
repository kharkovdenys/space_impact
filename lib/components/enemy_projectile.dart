import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_impact/components/projectile.dart';
import 'package:space_impact/components/player.dart';
import 'package:space_impact/views/screens/game.dart';

class EnemyProjectile extends SpriteComponent
    with CollisionCallbacks, HasGameRef<SpaceImpact> {
  final double _speed = 450;

  EnemyProjectile({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size) {
    anchor = Anchor.center;
    add(RectangleHitbox.relative(Vector2(0.4, 0.15625), parentSize: this.size));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(-1, 0) * _speed * dt;
    if (position.x < -32) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Projectile) {
      removeFromParent();
    } else if (other is Player) {
      gameRef.health--;
      gameRef.updateHealth();
      removeFromParent();
    }
  }
}
