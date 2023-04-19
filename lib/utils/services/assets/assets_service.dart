class AssetsService {
  static get SETTIN_ICON =>
      _getPath(assetsName: "setting.svg", assetsType: _AssetsType.kSvg);

  static get BACKGROUND_IMAGE =>
      _getPath(assetsName: "bg.png", assetsType: _AssetsType.kImage);

  static get ENG_FLAG =>
      _getPath(assetsName: "eng.png", assetsType: _AssetsType.kImage);
  static get PLAYER => "player.png";
  static get Enemy => "enemy.png";
  static get BALL => "game_ball.png";
  static get RUSS_FLAG =>
      _getPath(assetsName: "rus.png", assetsType: _AssetsType.kImage);
  static get BACK_ICON =>
      _getPath(assetsName: "back.svg", assetsType: _AssetsType.kSvg);

  static get BG_MUSIC => "bg_music.mp3";

  static get GROUND_IMAGE => "ground.png";

  static const _RIVE_PATH = "assets/rive_assets/";
  static const _IMAGE_PATH = "assets/images/";
  static const _LOTTIE_PATH = "assets/lotties/";
  static const _ICONS_PATH = "assets/svgs/";
  static const _AUDIO_PATH = "assets/audio/";

  static _getPath(
      {_AssetsType? assetsType = _AssetsType.kImage,
      required String assetsName}) {
    if (assetsType == _AssetsType.kImage) {
      return _IMAGE_PATH + assetsName;
    }

    if (assetsType == _AssetsType.kLottie) {
      return _LOTTIE_PATH + assetsName;
    }

    if (assetsType == _AssetsType.kAudio) {
      return _AUDIO_PATH + assetsName;
    }
    if (assetsType == _AssetsType.kSvg) {
      return _ICONS_PATH + assetsName;
    }
    if (assetsType == _AssetsType.kRiveFile) {
      return _RIVE_PATH + assetsName;
    }
  }
}

enum _AssetsType { kImage, kSvg, kLottie, kRiveFile, kAudio }
