import 'dart:math';

import 'package:ball_bomber/game/components/background.dart';
import 'package:ball_bomber/game/components/player.dart';
import 'package:ball_bomber/game/manager/enemy_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:provider/provider.dart';

import '../../provider/ball_data_provider.dart';

class MainGame extends FlameGame
    with
        HasCollisionDetection,
        HasDraggableComponents,
        HasDraggablesBridge,
        HasTappableComponents,
        TapCallbacks {
  final Background _background = Background();

  Enemyanager? _enemyanager;
  Player? _player;
  // Enemy? _enemy;

  @override
  Future<void>? onLoad() async {
    await add(_background);

    _player = Player(position: Vector2(size.x * .85, size.y / 2));
    _player!.anchor = Anchor.center;

    await add(_player!);
    _enemyanager = Enemyanager(postion: _player!.position);

    // _enemy = Enemy(position: size / 2, size: Vector2(50, 50));
    await add(_enemyanager!);

    return super.onLoad();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) async {
    Vector2 newDirection = Vector2.zero();
    newDirection.x = event.canvasPosition.x;
    -_player!.position.x;
    newDirection.y = event.canvasPosition.y - _player!.position.y;

    final hyp = sqrt(
        (newDirection.x * newDirection.x) + (newDirection.y * newDirection.y));

    newDirection.x /= hyp;
    newDirection.y /= hyp;

    _player!.ballDirection = Vector2(-newDirection.x, newDirection.y);

    super.onDragUpdate(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    Vector2 newDirection = Vector2.zero();
    newDirection.x = event.canvasPosition.x;
    -_player!.position.x;
    newDirection.y = event.canvasPosition.y - _player!.position.y;

    final hyp = sqrt(
        (newDirection.x * newDirection.x) + (newDirection.y * newDirection.y));

    newDirection.x /= hyp;
    newDirection.y /= hyp;

    _player!.ballDirection = Vector2(-newDirection.x, newDirection.y);

    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    if (buildContext != null) {
      final provider =
          Provider.of<BallDataProvider>(buildContext!, listen: false);
      final playerHealth = provider.playersLife;
      final elapsedTime = provider.timeElapsed;
      for (var element in overlays.activeOverlays) {
        print(element.toString());
      }

      if (playerHealth <= 0 && elapsedTime > 0) {
        pauseEngine();

        provider.updateWon(false);
      } else if (playerHealth >= 0 && elapsedTime <= 0) {
        pauseEngine();
        provider.updateWon(true);
      }
    }
    super.update(dt);
  }

  void reset() {
    if (buildContext != null) {
      Provider.of<BallDataProvider>(buildContext!, listen: false).resetHealth();
    }
  }
}
