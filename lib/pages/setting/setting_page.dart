import 'package:ball_bomber/app_constant.dart';
import 'package:ball_bomber/pages/setting/widget/setting_widget.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:ball_bomber/utils/dynamic_widgets/custom_appbar.dart';
import 'package:ball_bomber/utils/dynamic_widgets/scaffold_widget.dart';
import 'package:ball_bomber/utils/enums/language.dart';
import 'package:ball_bomber/utils/functions/getCustomTextStyle.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ball, _) {
      return ScaffoldWidget(
          // appBarHeadingWidget: CustomText(
          //   text: AppConstant.SETTING,
          //   style: const TextStyle(
          //       fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 1.2),
          // ),
          body: Center(
              child: TransparentDefaultAppBar(
        title: AppConstant.SETTING,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SettingWidget(
                      onChanged: (val) async {
                        ball.updateVibration(val);
                        await ball.saveVibration();
                      },
                      title: AppConstant.VIBRATION,
                      val: ball.vibration,
                    ),
                    SettingWidget(
                      onChanged: (val) async {
                        ball.updateSound(val);
                        await ball.saveSound();
                        ball.controlMusic();
                      },
                      title: AppConstant.SOUND,
                      val: ball.sound,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: AppConstant.LANGUAGE,
                          style: getCustomTextStyle(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppConstant.WHITE_TEXT,
                                  fontSize: 24)),
                        ),
                        AppConstant.V_BOX_3,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                ball.updateCurrentLanguage(Language.kEnglish);
                                await ball.saveLanguage();
                              },
                              child: Opacity(
                                opacity:
                                    ball.currentLanguage == Language.kEnglish
                                        ? 1
                                        : 0.3,
                                child: Image.asset(
                                  AssetsService.ENG_FLAG,
                                  height: 40,
                                ),
                              ),
                            ),
                            AppConstant.H_BOX_4,
                            GestureDetector(
                              onTap: () async {
                                ball.updateCurrentLanguage(Language.kRussian);
                                await ball.saveLanguage();
                              },
                              child: Opacity(
                                opacity:
                                    ball.currentLanguage == Language.kRussian
                                        ? 1
                                        : 0.3,
                                child: Image.asset(
                                  AssetsService.RUSS_FLAG,
                                  height: 40,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )));
    });
  }
}
