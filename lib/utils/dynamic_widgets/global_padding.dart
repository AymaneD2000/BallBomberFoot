import 'package:flutter/cupertino.dart';

import '../../app_constant.dart';

class GlobalPadding extends StatelessWidget {
  Widget child;
  GlobalPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstant.GLOBAL_HORIZONTAL_PADDING,
          vertical: AppConstant.GLOBAL_VERTICAL_PADDING,
        ),
        child: child);
  }
}
