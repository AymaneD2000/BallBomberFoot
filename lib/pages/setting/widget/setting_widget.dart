import 'package:flutter/cupertino.dart';

import '../../../app_constant.dart';
import '../../../utils/functions/getCustomTextStyle.dart';

class SettingWidget extends StatelessWidget {
  final bool? val;
  final Function(bool val)? onChanged;
  final String? title;
  const SettingWidget(
      {super.key,
      required this.onChanged,
      required this.title,
      required this.val});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: title,
          style: getCustomTextStyle(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppConstant.WHITE_TEXT,
                  fontSize: 24)),
        ),
        AppConstant.V_BOX_1,
        CupertinoSwitch(
            thumbColor: val ?? false
                ? AppConstant.SECONDARY_COLOR
                : AppConstant.SWITCH_ACTIVE_COLOR,
            activeColor: AppConstant.SWITCH_ACTIVE_COLOR,
            trackColor: AppConstant.BACKGROUND_COLOR,
            value: val ?? false,
            onChanged: (val) {
              onChanged!(val);
            })
      ],
    );
  }
}
