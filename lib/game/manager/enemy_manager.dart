import 'dart:math';

import 'package:ball_bomber/game/components/enemy.dart';
import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/game/utils/knows_game_size.dart';
import 'package:flame/components.dart';

class Enemyanager extends Component with KnowsGameSize, HasGameRef<MainGame> {
  Timer? _timer;

  Random random = Random();
  Vector2? postion;

  Enemyanager({required this.postion}) : super() {
    _timer = Timer(0.9, onTick: _spawnEnemy, repeat: true);
    _timer?.start();
  }

  void _spawnEnemy() {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(
      0,
      random.nextDouble() * gameRef.size.x,
    );

    // position.clamp(
    //     Vector2.zero() + initialSize / 2, gameRef.size - initialSize / 2);
    Enemy enemy = Enemy(
        position: position, size: Vector2(50, 50), moveDirection: postion);

    enemy.anchor = Anchor.center;
    gameRef.add(enemy);
  }

  @override
  @override
  void onMount() {
    _timer?.start();
    super.onMount();
  }

  @override
  void onRemove() {
    _timer?.stop();
    super.onRemove();
  }

  @override
  void update(double dt) {
    _timer?.update(dt);
    super.update(dt);
  }

  void reset() {
    _timer?.stop();
    _timer?.start();
  }
}
