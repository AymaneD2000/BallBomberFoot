import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/pages/game_page/overlays/pause_button.dart';
import 'package:ball_bomber/pages/game_page/overlays/pause_menu_overlay.dart';
import 'package:ball_bomber/pages/game_page/overlays/time_and_hp_overlay.dart';
import 'package:ball_bomber/pages/game_page/overlays/win_loss_page.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  final MainGame _game = MainGame();
  BallDataProvider? ballData;
  final duration = const Duration(seconds: 90);
  final curve = Curves.easeIn;

  @override
  void initState() {
    ballData = Provider.of<BallDataProvider>(context, listen: false);
    ballData?.timerAnimationController =
        AnimationController(vsync: this, duration: duration);
    ballData?.timerAnimationController?.forward();
    ballData?.updateTime();

    super.initState();
  }

  @override
  void dispose() {
    ballData?.timerAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ballData, _) {
      return ballData.won != null
          ? const WinLossPage()
          : Scaffold(
              body: Stack(
                children: [
                  Center(
                      child: GameWidget(
                    game: _game,
                    initialActiveOverlays: const [PauseButton.id],
                    overlayBuilderMap: {
                      PauseButton.id:
                          (BuildContext context, MainGame gameRef) =>
                              PauseButton(
                                gameRef: gameRef,
                              ),
                    },
                  )),
                  const TimeAndHpOverlay(),
                  if (ballData.pause!) ...{
                    PauseMenuOverlay(
                      gameref: _game,
                    )
                  }
                ],
              ),
            );
    });
  }
}
