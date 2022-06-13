import 'package:flame/components.dart';
import 'package:flame/geometry.dart';


import 'projectile.dart';
import 'player.dart';

import '../game.dart';

class EnemyProjectile extends SpriteComponent with HasHitboxes, Collidable,HasGameRef<SpaceImpact>{
  final double _speed = 450;
  EnemyProjectile({Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size) {
    anchor = Anchor.center;
    addHitbox(HitboxRectangle(relation: Vector2(0.4,0.15625)));
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
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Projectile) {
        removeFromParent();
    }else
      if(other is Player){
        gameRef.health--;
        gameRef.updateHealth();
        removeFromParent();
    }
  }
}