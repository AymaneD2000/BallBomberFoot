import 'dart:developer';

import 'package:ball_bomber/game/components/enemy.dart';
import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ball extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  final double _speed = 450;

  Vector2? direction;

  Ball({required Vector2? position, required this.direction})
      : super(position: position);

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(AssetsService.BALL);
    size = Vector2(25, 25);

    return super.onLoad();
  }

  @override
  void onMount() {
    final shape =
        CircleHitbox.relative(.8, parentSize: size, position: size / 2);

    add(shape);

    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      log("yess...");
      other.hpBar!.health = other.hpBar!.health - 1;
      other.health = other.health - 1;
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += (direction ?? Vector2(-1, 0)) * _speed * dt;
    angle *= dt;

    if (position.x < 0) {
      log("removing..");
      removeFromParent();
    }
  }
}
