import 'package:ball_bomber/app_constant.dart';
import 'package:ball_bomber/page_constant.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:ball_bomber/utils/dynamic_widgets/custom_button.dart';
import 'package:ball_bomber/utils/dynamic_widgets/scaffold_widget.dart';
import 'package:ball_bomber/utils/functions/getCustomTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WinLossPage extends StatefulWidget {
  static const String id = "WindLossPage";

  const WinLossPage({
    Key? key,
  }) : super(key: key);

  @override
  State<WinLossPage> createState() => _WinLossPageState();
}

class _WinLossPageState extends State<WinLossPage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  final duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.easeInCubic));

    _animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BallDataProvider>(builder: (context, ballData, _) {
      return FadeTransition(
        opacity: _animation!,
        child: ScaffoldWidget(
            showAppbar: false,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: ballData.won ?? false
                        ? AppConstant.YOU_WIN
                        : AppConstant.YOU_LOSE,
                    style: getCustomTextStyle(
                        textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    )),
                  ),
                  AppConstant.V_BOX_2,
                  CustomButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, PageConstant.HOME_PAGE);
                    },
                    title: AppConstant.MENU,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )
                ],
              ),
            )),
      );
    });
  }
}
