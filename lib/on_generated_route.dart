import 'package:ball_bomber/page_constant.dart';
import 'package:ball_bomber/pages/game_page/game_Page.dart';
import 'package:ball_bomber/pages/home_page/ball_bomber_home_page.dart';
import 'package:ball_bomber/pages/setting/setting_page.dart';
import 'package:ball_bomber/pages/splash/splash_page.dart';

import 'package:flutter/material.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case PageConstant.HOME_PAGE:
        {
          return CustomPageRoute(child: const BallBomberHomePage());
        }
      case PageConstant.SPALSH_PAGE:
        {
          return CustomPageRoute(child: const SplashPage());
        }
      case PageConstant.SETTING_PAGE:
        {
          return CustomPageRoute(child: const SettingPage());
        }

      case PageConstant.GAME_PAGE:
        {
          return CustomPageRoute(child: const GamePage());
        }

      default:
        return CustomPageRoute(child: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [Text("Error Occurred")],
      ),
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (ctx, animation, secAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              var curve = Curves.easeInCubic;

              var curveTween = CurveTween(curve: curve);
              final tween =
                  Tween<double>(begin: begin, end: end).chain(curveTween);

              final offsetAnimation = animation.drive(tween);
              return FadeTransition(
                opacity: offsetAnimation,
                child: child,
              );
            },
            pageBuilder: (context, animation, secAnimation) {
              return child;
            });
}

showAnimatedDialog(Widget child, context,
    {bool barrierDismissal = true, Function()? function}) {
  showGeneralDialog(
      barrierLabel: "a",
      barrierDismissible: barrierDismissal,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInCubic));

        return FadeTransition(
          opacity: tween,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      context: context,
      pageBuilder: (ctx, anim, anim2) {
        return child;
      }).then((value) {
    if (function != null) {
      function();
    }
  });
}
