// This class represents the pause button overlay.
import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/pages/game_page/overlays/pause_menu_overlay.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  static const String id = 'PauseButton';
  final MainGame gameRef;

  const PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ballData, _) {
      return Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          child: const Icon(
            Icons.pause_rounded,
            color: Colors.red,
            size: 40,
          ),
          onPressed: () {
            ballData.timer?.cancel();
            ballData.updatePause(true);
            ballData.timerAnimationController?.stop();
            gameRef.pauseEngine();
          },
        ),
      );
    });
  }
}
