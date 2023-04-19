import 'package:flutter/material.dart';

import '../../app_constant.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Center(
            child: Icon(
          Icons.arrow_back_ios_outlined,
          color: AppConstant.SECONDARY_COLOR,
        )),
      ),
    );
  }
}
