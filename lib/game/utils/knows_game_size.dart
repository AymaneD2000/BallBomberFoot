import 'package:flame/components.dart';

mixin KnowsGameSize on Component {
  late Vector2 gameSize;

  @override
  void onGameResize(Vector2 size) {
    gameSize = size;
    super.onGameResize(size);
  }
}
