import 'package:flutter/material.dart';

import '../../app_constant.dart';
import '../functions/getCustomTextStyle.dart';

class CustomButton extends StatelessWidget {
  EdgeInsets? contentPadding;
  Widget? child;
  String? title;
  FontStyle? fontStyle;
  double? fontSize;
  FontWeight? fontWeight;
  Function()? onTap;
  double? width;
  double? height;
  Color? color;
  CustomButton(
      {Key? key,
      this.contentPadding,
      this.child,
      this.onTap,
      this.width,
      this.height,
      this.fontWeight,
      this.color,
      this.fontStyle,
      this.title,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? 200,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(color ?? AppConstant.BUTTON_COLOR),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))),
          onPressed: onTap,
          child: Center(
            child: child ??
                CustomText(
                  text: title ?? "",
                  style: getCustomTextStyle(
                      textStyle: TextStyle(
                    fontWeight: fontWeight ?? FontWeight.w400,
                    color: AppConstant.PRIMARY_COLOR,
                    fontSize: fontSize ?? 16,
                    fontStyle: fontStyle ?? FontStyle.normal,
                  )),
                ),
          )),
    );
  }
}
