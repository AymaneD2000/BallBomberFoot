import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:ball_bomber/data_source/game_local_data_source.dart';
import 'package:ball_bomber/utils/enums/language.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:ball_bomber/utils/services/audio/audio_manager.dart';
import 'package:flutter/cupertino.dart';

class BallDataProvider extends ChangeNotifier {
  final double maxTime = 90;
  double timeElapsed = 90;
  bool? won;
  bool? pause = false;

  AudioPlayer backgroundPayer = AudioPlayer();

  AnimationController? timerAnimationController;

  Timer? timer;
  double playersLife = 100;
  Language? currentLanguage;
  Stream? stream;
  StreamSubscription? timerSubscription;
  bool? vibration;
  bool? sound;
  void updateWon(bool val) {
    won = val;
    timerSubscription?.cancel();

    notifyListeners();
  }

  void updatePause(bool val) {
    pause = val;
    notifyListeners();
  }

  void resetGame() {
    timeElapsed = maxTime;

    won = null;
    timer?.cancel();

    playersLife = 100;
    notifyListeners();
  }

  void updateVibration(bool val) {
    vibration = val;
    notifyListeners();
  }

  Future getAndUpdateSettings() async {
    final vib = await getVibration();
    final sd = await getSound();
    final lang = await getLanguage();
    currentLanguage = lang;
    vibration = vib;
    sound = sd;
    notifyListeners();
  }

  Future<bool> getVibration() async {
    final vib = await GameDataSource.getVibration();
    return vib!;
  }

  Future<bool> getSound() async {
    final sound = await GameDataSource.getSound();
    return sound!;
  }

  Future<Language> getLanguage() async {
    final lang = await GameDataSource.getLanguage();
    Language language = lang == "eng" ? Language.kEnglish : Language.kRussian;
    return language;
  }

  Future saveVibration() async {
    await GameDataSource.saveVibration(vibration);
  }

  Future saveSound() async {
    await GameDataSource.saveSound(sound);
  }

  Future saveLanguage() async {
    String lang = currentLanguage == Language.kEnglish ? "eng" : "rus";

    await GameDataSource.saveLanguage(lang);
  }

  void updatePlayerLife() async {
    if (playersLife > 0) {
      playersLife = playersLife - 15;
      notifyListeners();
    }
  }

  resetHealth() {
    playersLife = 100;
    notifyListeners();
  }

  Future loadAudios() async {
    const path = "assets/audio/";
    backgroundPayer.audioCache.prefix = path;

    await backgroundPayer.audioCache.load("bg_music.mp3");
  }

  Future controlMusic() async {
    if (sound ?? false) {
      await AudioService.playSingleSound(
        audioPath: AssetsService.BG_MUSIC,
        playerMode: PlayerMode.mediaPlayer,
        player: backgroundPayer,
      );
    } else {
      await backgroundPayer.stop();
    }
  }

  updateTime({bool isForInitAndDispose = false}) async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeElapsed > 0) {
        timeElapsed--;

        notifyListeners();
      } else {
        timer.cancel();

        notifyListeners();
      }
    });

    isForInitAndDispose ? notifyListeners() : null;
  }

  void updateCurrentLanguage(Language language) {
    currentLanguage = language;
    notifyListeners();
  }

  void updateSound(bool val) {
    sound = val;
    notifyListeners();
  }
}
