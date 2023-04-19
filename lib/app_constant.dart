import 'package:flutter/material.dart';

// import 'dynamic_widgets/custom_text_style.dart';

class AppConstant {
  static const PRIMARY_COLOR = Color(0xff2b5fa9);

  static const SECONDARY_COLOR = Colors.white;
  static const BACKGROUND_COLOR = Color(0xffD0D0D0);

  static const ENEMY_COLOR = Color(0xff9F261F);
  static const APP_BAR_COLOR = Color.fromRGBO(3, 24, 51, 1);
  static const SWITCH_ACTIVE_COLOR = Color(0xff1060AE);

  static const WHITE_TEXT = Colors.white;
  static const BUTTON_COLOR = Colors.white;

  static const GLOBAL_HORIZONTAL_PADDING = 50.0;
  static const GLOBAL_VERTICAL_PADDING = 23.0;
  static const GLOBAL_HORIZONTAL_PADDING_TAB = 17.0;
  static const GLOBAL_VERTICAL_PADDING_TAB = 8.0;

  static const MARGIN_1 = 5.0;
  static const MARGIN_2 = 10.0;
  static const MARGIN_3 = 15.0;
  static const MARGIN_4 = 20.0;
  static const MARGIN_5 = 25.0;
  static const MARGIN_6 = 30.0;
  static const MARGIN_7 = 35.0;

  // final CUSTOM_BUTTON_TEXT_STYLE = getCustomTextStyle(
  //  t   color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500);

  static const V_BOX_1 = SizedBox(
    height: MARGIN_1,
  );

  static const V_BOX_2 = SizedBox(height: MARGIN_2);
  static const V_BOX_3 = SizedBox(
    height: MARGIN_3,
  );
  static const V_BOX_4 = SizedBox(
    height: MARGIN_4,
  );
  static const V_BOX_5 = SizedBox(
    height: MARGIN_5,
  );
  static const V_BOX_6 = SizedBox(
    height: MARGIN_6,
  );
  static const V_BOX_7 = SizedBox(
    height: MARGIN_7,
  );

  static const H_BOX_1 = SizedBox(
    width: MARGIN_1,
  );

  static const H_BOX_2 = SizedBox(width: MARGIN_2);
  static const H_BOX_3 = SizedBox(
    width: MARGIN_3,
  );
  static const H_BOX_4 = SizedBox(
    width: MARGIN_4,
  );
  static const H_BOX_5 = SizedBox(
    width: MARGIN_5,
  );
  static const H_BOX_6 = SizedBox(
    width: MARGIN_6,
  );
  static const H_BOX_7 = SizedBox(
    width: MARGIN_7,
  );
  static const String START = "START";
  static const String SETTING = "SETTINGS";
  static const String VIBRATION = "VIBRATION";
  static const String SOUND = "SOUND";
  static const String LANGUAGE = "LANGUAGE";
  static const String YOU_WIN = "YOU WIN!";
  static const String YOU_LOSE = "YOU LOSE";
  static const String TIME = "TIME";
  static const String MENU = "MENU";
  static const String RESUME = "RESUME";

  static const String Football_Bombing = "Football Bombing";

  static const Map<String, dynamic> langugaeMap = {
    Football_Bombing: "Football Bombing",
    MENU: "МЕНЮ",
    START: " СТАРТ",
    SETTING: "НАСТРОЙКИ",
    VIBRATION: "ВИБРАЦИЯ",
    SOUND: "ЗВУК",
    LANGUAGE: "ЯЗЫК",
    YOU_WIN: "ТЫ ПОБЕДИЛ!",
    YOU_LOSE: "ТЫ ПРОИГРАЛ",
    RESUME: "продолжать"
  };
}
