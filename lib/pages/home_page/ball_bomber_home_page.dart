import 'package:ball_bomber/app_constant.dart';
import 'package:ball_bomber/page_constant.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:ball_bomber/utils/dynamic_widgets/custom_button.dart';
import 'package:ball_bomber/utils/dynamic_widgets/scaffold_widget.dart';
import 'package:ball_bomber/utils/functions/getCustomTextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BallBomberHomePage extends StatefulWidget {
  const BallBomberHomePage({super.key});

  @override
  State<BallBomberHomePage> createState() => _BallBomberHomePageState();
}

class _BallBomberHomePageState extends State<BallBomberHomePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    controllSound();
    super.initState();
  }

  controllSound() async {
    await Provider.of<BallDataProvider>(context, listen: false).controlMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ballData, _) {
      return ScaffoldWidget(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: AppConstant.Football_Bombing,
            style: getArtifikaFont(
                textStyle: const TextStyle(
              color: AppConstant.WHITE_TEXT,
              fontSize: 52,
              fontWeight: FontWeight.w400,
            )),
          ),
          AppConstant.V_BOX_7,
          CustomButton(
            fontWeight: FontWeight.w700,
            title: AppConstant.START,
            onTap: () {
              if (ballData.timerAnimationController?.isAnimating ?? false) {
                ballData.timerAnimationController?.dispose();
              }
              ballData.resetGame();
              ballData.updatePause(false);

              Navigator.pushNamed(context, PageConstant.GAME_PAGE);
            },
          ),
          AppConstant.V_BOX_4,
          CustomButton(
            fontWeight: FontWeight.w700,
            title: AppConstant.SETTING,
            onTap: () {
              Navigator.pushNamed(context, PageConstant.SETTING_PAGE);
            },
          ),
        ],
      ));
    });
  }
}
