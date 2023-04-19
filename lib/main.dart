import 'package:ball_bomber/page_constant.dart';
import 'package:ball_bomber/provider/ball_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'on_generated_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BallDataProvider>(create: (ctx) {
          return BallDataProvider()
            ..getAndUpdateSettings()
            ..loadAudios()
            ..controlMusic();
        })
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: PageConstant.HOME_PAGE,
        onGenerateRoute: OnGenerateRoute.route,
      ),
    );
  }
}
