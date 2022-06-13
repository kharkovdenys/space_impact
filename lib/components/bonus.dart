import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'player.dart';

import '../game.dart';

class Bonus extends SpriteComponent with HasHitboxes, Collidable,HasGameRef<SpaceImpact> {
  final double _speed = 250;
  late int _type;
  Bonus({Sprite? sprite, Vector2? position, Vector2? size,int? type})
      : super(sprite: sprite, position: position, size: size) {
    _type=type!;
    anchor = Anchor.center;
    addHitbox(HitboxCircle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(-1, 0) * _speed * dt;
    if (position.x <-size.x/2) {
      removeFromParent();
    }
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      if(_type==1){
        if(gameRef.health!=3)
          {
            gameRef.health++;
            gameRef.updateHealth();
          }
      }
      else{
        if(gameRef.superShots!=10)
        {
          gameRef.superShots++;
          gameRef.updateSuperShots();
        }
      }
      removeFromParent();
    }
  }
}
