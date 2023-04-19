import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static AudioCache? _audioCache;

  static Future playSingleSound(
      {required String audioPath,
      bool? loop = false,
      PlayerMode? playerMode = PlayerMode.lowLatency,
      required AudioPlayer player}) async {
    player.setPlayerMode(playerMode!);
    if (loop!) {
      player.setReleaseMode(ReleaseMode.loop);
    }

    await player.play(AssetSource(audioPath));
    // await player.play(AssetSource("audio/$audioPath"));

    // await player
    //     .play(DeviceFileSource(audioPath))
    //     .then((value) => log("playing.."));
  }

  static void stopSound(AudioPlayer player) async {
    await player.stop();
  }

  static void pauseSound(AudioPlayer player) async {
    await player.pause();
  }
}
