import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './utils/app_routes.dart';
import './utils/app_theme.dart';
import 'package:get/get.dart';
import './views/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  MyApp({Key? key}) : super(key: key);
  // HomePage homePage = (HomePage());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Izaaz News Application',
      // theme: Themes.appTheme,
      // theme: homePage.isSwitched ? Themes.darkTheme : Themes.appTheme,

      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
