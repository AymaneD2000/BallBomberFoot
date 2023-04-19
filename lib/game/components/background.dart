import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(AssetsService.GROUND_IMAGE);
    size = gameRef.size;

    return super.onLoad();
  }
}
