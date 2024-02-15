import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_ui/pages/devices_page.dart';
import 'package:smart_home_ui/pages/intro_page.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';
import 'package:smart_home_ui/pages/home_page.dart';

import 'models/home_devices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(375, 750));
    WindowManager.instance.setMaximumSize(const Size(375, 750));
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(ChangeNotifierProvider(
    create: (context) => HomeDevices(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     scrollbarTheme: ScrollbarThemeData(
      //         thumbVisibility: MaterialStateProperty.all<bool>(true))),
      home: IntroPage(),
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/home_page': (context) => const HomePage(),
        '/device_page': (context) => const DevicesPage(),
      },
    );
  }
}
