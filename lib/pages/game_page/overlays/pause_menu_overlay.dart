import 'dart:developer';
import 'dart:ui';

import 'package:ball_bomber/app_constant.dart';
import 'package:ball_bomber/game/main_game/main_game.dart';
import 'package:ball_bomber/page_constant.dart';
import 'package:ball_bomber/pages/game_page/overlays/pause_button.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:ball_bomber/utils/dynamic_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../setting/widget/setting_widget.dart';

class PauseMenuOverlay extends StatelessWidget {
  static const String id = "pause_menu";
  MainGame? gameref;
  PauseMenuOverlay({Key? key, required this.gameref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ballData, _) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: AppConstant.PRIMARY_COLOR,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  title: AppConstant.RESUME,
                  onTap: () {
                    ballData.updatePause(false);
                    ballData.updateTime(isForInitAndDispose: true);
                    ballData.timerAnimationController?.forward();
                    log(ballData.timeElapsed.toString());

                    gameref?.resumeEngine();

                    gameref?.overlays.add(PauseButton.id);
                    gameref?.overlays.remove(id);
                  },
                ),
                AppConstant.V_BOX_4,
                CustomButton(
                  title: AppConstant.MENU,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, PageConstant.HOME_PAGE);
                  },
                ),
                AppConstant.V_BOX_7,
                AppConstant.V_BOX_7,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SettingWidget(
                      onChanged: (val) async {
                        ballData.updateSound(val);
                        await ballData.saveSound();
                        ballData.controlMusic();
                      },
                      title: AppConstant.SOUND,
                      val: ballData.sound,
                    ),
                    AppConstant.H_BOX_5,
                    SettingWidget(
                      onChanged: (val) async {
                        ballData.updateVibration(val);
                        await ballData.saveVibration();
                      },
                      title: AppConstant.VIBRATION,
                      val: ballData.vibration,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
