import 'package:ball_bomber/utils/functions/getCustomTextStyle.dart';
import 'package:ball_bomber/utils/services/assets/assets_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_constant.dart';
import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget? title;
  CustomAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: title ?? AppConstant.H_BOX_1,
      leadingWidth: 75,
      leading: const Padding(
        padding: EdgeInsets.all(5.0),
        child: CustomBackButton(),
      ),
      backgroundColor: Colors.transparent.withOpacity(0),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class TransparentDefaultAppBar extends StatelessWidget {
  Widget? appBarHeading;
  String? title;
  Widget? child;

  TransparentDefaultAppBar(
      {super.key, this.appBarHeading, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                AssetsService.BACK_ICON,
                height: 24,
                width: 9,
              ),
            ),
            CustomText(
              text: title,
              style: getCustomTextStyle(
                  textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppConstant.WHITE_TEXT,
                      letterSpacing: 0.5)),
            ),
            AppConstant.H_BOX_1,
          ],
        ),
        Expanded(child: child ?? AppConstant.V_BOX_1)

        // AppBar(
        //   centerTitle: true,
        //   elevation: 0,
        //   title: title ?? AppConstant.H_BOX_1,
        //   leadingWidth: 75,
        //   leading: const Padding(
        //     padding: EdgeInsets.all(5.0),
        //     child: CustomBackButton(),
        //   ),
        //   backgroundColor: Colors.transparent.withOpacity(0),
        // ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
