import 'dart:math';

import 'package:ball_bomber/game/components/ball.dart';
import 'package:ball_bomber/game/components/enemy.dart';
import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/game/utils/knows_game_size.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/ball_data_provider.dart';

class Player extends SpriteComponent
    with
        KnowsGameSize,
        CollisionCallbacks,
        HasGameRef<MainGame>,
        KeyboardHandler {
  Timer? _playerHealthTimer;
  Timer? _ballFireTimer;
  bool? decreaseHealth;

  Vector2? ballDirection;
  Player({Vector2? position, this.ballDirection}) : super(position: position) {
    decreaseHealth = false;
    _playerHealthTimer = Timer(1, repeat: true, onTick: () {
      if (decreaseHealth!) {
        if (gameRef.buildContext != null) {
          Provider.of<BallDataProvider>(gameRef.buildContext!, listen: false)
              .updatePlayerLife();
        }
        _playerHealthTimer?.start();
      } else {
        _playerHealthTimer?.pause();
      }
    });

    _ballFireTimer = Timer(
      0.3,
      onTick: () {
        fireball();
      },
      repeat: true,
    );
    _ballFireTimer!.start();
  }

  set isDecreaseHealth(bool val) {
    decreaseHealth = val;
  }

  // int get health => _health;
  final _random = Random();

  Vector2 getRandomVector() {
    return (Vector2.random(_random) - Vector2.random(_random)) * 500;
  }

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(AssetsService.PLAYER);
    size = Vector2(50, 50);

    return super.onLoad();
  }

  @override
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    super.onCollision(intersectionPoints, other);

    if (other is Enemy) {
      print(decreaseHealth.toString());
      _playerHealthTimer?.resume();

      decreaseHealth = true;

      final particleComponent = ParticleSystemComponent(
        particle: Particle.generate(
          count: 2,
          lifespan: 0.1,
          generator: (i) => AcceleratedParticle(
            acceleration: getRandomVector(),
            speed: getRandomVector(),
            position: position.clone(),
            child: CircleParticle(
              radius: 2,
              paint: Paint()..color = const Color.fromARGB(255, 242, 222, 7),
            ),
          ),
        ),
      );

      gameRef.add(particleComponent);
    } else {
      _playerHealthTimer?.pause();
      decreaseHealth = false;
    }
  }

  @override
  void update(double dt) {
    _playerHealthTimer?.update(dt);
    _ballFireTimer?.update(dt);

    super.update(dt);
  }

  @override
  void onMount() {
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
    super.onMount();
  }

  void fireball() async {
    Ball ball = Ball(
      direction: ballDirection,
      position: position.clone(),
    );
    ball.anchor = Anchor.center;
    gameRef.add(ball);
  }
}
