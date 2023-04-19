import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_constant.dart';
import '../../../utils/functions/getCustomTextStyle.dart';

class TimeAndHpOverlay extends StatefulWidget {
  static const String id = "TimeAndHpOverlay";
  const TimeAndHpOverlay({super.key});

  @override
  State<TimeAndHpOverlay> createState() => _TimeAndHpOverlayState();
}

class _TimeAndHpOverlayState extends State<TimeAndHpOverlay> {
  BallDataProvider? _provider;

  @override
  void initState() {
    _provider = Provider.of<BallDataProvider>(context, listen: false);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ballData, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            AppConstant.V_BOX_4,
            SizedBox(
              height: 20,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  AnimatedBuilder(
                      animation: ballData.timerAnimationController!,
                      builder: (context, _) {
                        return LinearProgressIndicator(
                          minHeight: 18,
                          backgroundColor: AppConstant.BACKGROUND_COLOR,
                          color: AppConstant.SWITCH_ACTIVE_COLOR,
                          value: 1 - ballData.timerAnimationController!.value,
                        );
                      }),
                  Center(
                      child: CustomText(
                    text: AppConstant.TIME,
                    style: getCustomTextStyle(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppConstant.WHITE_TEXT)),
                  ))
                ],
              ),
            ),
            // AppConstant.V_BOX_1,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                        minHeight: 10,
                        backgroundColor: AppConstant.BACKGROUND_COLOR,
                        color: AppConstant.ENEMY_COLOR,
                        value: ballData.playersLife / 100),
                  ),
                  AppConstant.H_BOX_1,
                  CustomText(
                    text: "HP",
                    style: getCustomTextStyle(
                        textStyle: const TextStyle(
                            color: AppConstant.ENEMY_COLOR,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
