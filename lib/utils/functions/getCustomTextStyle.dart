import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../app_constant.dart';
import '../../provider/ball_data_provider.dart';
import '../enums/language.dart';

TextStyle getCustomTextStyle({required TextStyle textStyle}) {
  return GoogleFonts.roboto(textStyle: textStyle);
}

TextStyle getArtifikaFont({required TextStyle textStyle}) {
  return GoogleFonts.artifika(textStyle: textStyle);
}

class CustomText extends StatelessWidget {
  TextStyle? style;
  String? text;
  CustomText({Key? key, this.text, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<BallDataProvider, Language>(selector: (ctx, data) {
      return data.currentLanguage ?? Language.kEnglish;
    }, builder: (context, state, _) {
      return Text(
        _getText(state, text ?? ""),
        style: style ?? getCustomTextStyle(textStyle: const TextStyle()),
      );
    });
  }

  String _getText(Language state, String text) {
    if (state == Language.kEnglish) {
      return text;
    } else {
      try {
        return AppConstant.langugaeMap[text];
      } catch (e) {
        return text;
      }
    }
  }
}
