import 'dart:math';

import 'package:ball_bomber/app_constant.dart';
import 'package:ball_bomber/game/components/ball.dart';
import 'package:ball_bomber/game/components/enemy_heath_bar.dart';
import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/game/utils/knows_game_size.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Enemy extends SpriteComponent
    with
        KnowsGameSize,
        CollisionCallbacks,
        HasGameRef<MainGame>,
        KeyboardHandler {
  double speed = 115;
  double health = 3;
  Vector2? moveDirection;
  final _random = Random();
  final int _hitPoint = 10;

  HealthBar? hpBar;
  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  Vector2 _getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  Enemy(
      {required Vector2? position,
      required Vector2? size,
      required this.moveDirection})
      : super(position: position, size: size) {
    hpBar = HealthBar(health: health);
  }

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(AssetsService.Enemy);

    return super.onLoad();
  }

  @override
  void onMount() {
    final shape = CircleHitbox.relative(1,
        parentSize: size * 2, position: size / 2, anchor: Anchor.center);

    add(shape);
    hpBar?.angle = -pi / 2;
    add(hpBar!);

    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      final particleComponent = ParticleSystemComponent(
        particle: Particle.generate(
          count: 20,
          lifespan: 0.1,
          generator: (i) => AcceleratedParticle(
            acceleration: getRandomVector(),
            speed: getRandomVector(),
            position: position.clone(),
            child: CircleParticle(
              radius: 2,
              paint: Paint()..color = AppConstant.ENEMY_COLOR,
            ),
          ),
        ),
      );
      if (gameRef.buildContext != null) {
        final vib =
            Provider.of<BallDataProvider>(gameRef.buildContext!, listen: false)
                .vibration;
        if (vib!) {
          HapticFeedback.vibrate();
        }
      }

      gameRef.add(particleComponent);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    if (health <= 0) {
      removeFromParent();
    }
    final vector = Vector2.zero();
    vector.x = moveDirection!.x - (position.x * 1);
    vector.y = moveDirection!.y - position.y;

    final hyp = sqrt(vector.x * vector.x + vector.y * vector.y);
    vector.x /= hyp;
    vector.y /= hyp;

    final normalizedVect = Vector2(vector.x, vector.y);
    // }

    position += normalizedVect * speed * dt;

    super.update(dt);
  }

  void destroyPlayer() {
    if (gameRef.buildContext != null) {
      Provider.of<BallDataProvider>(gameRef.buildContext!, listen: false)
          .updatePlayerLife();
    }
  }
}
