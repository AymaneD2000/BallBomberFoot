import 'package:ball_bomber/utils/dynamic_widgets/custom_appbar.dart';
import 'package:ball_bomber/utils/dynamic_widgets/global_padding.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flutter/material.dart';

import '../../app_constant.dart';

class ScaffoldWidget extends StatelessWidget {
  bool? isMainGamePage;
  Widget? appBarHeadingWidget;

  bool? showAppbar;
  Widget body;
  ScaffoldWidget(
      {super.key,
      required this.body,
      this.appBarHeadingWidget,
      this.isMainGamePage = false,
      this.showAppbar = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.PRIMARY_COLOR,
      appBar: showAppbar!
          ? CustomAppBar(
              title: appBarHeadingWidget,
            )
          : null,
      body: isMainGamePage!
          ? body
          : Container(
              decoration: const BoxDecoration(
                color: AppConstant.PRIMARY_COLOR,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 1,
                    child: Image.asset(
                      AssetsService.BACKGROUND_IMAGE,
                      fit: BoxFit.fill,
                      height: size.height * 1.5,
                      width: size.width,
                    ),
                  ),
                  GlobalPadding(child: body),
                ],
              )),
    );
  }
}
