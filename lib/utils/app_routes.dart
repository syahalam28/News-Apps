import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:news_project/views/Login_page.dart';

import '../views/home_page.dart';
import '../views/onboarding_page.dart';
import './route_name.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/homepage';
  static const onBoard = RouteName.onBoard;
  static final routes = [
    GetPage(
        name: RouteName.home,
        page: () => HomePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: RouteName.onBoard,
        page: () => OnboardingPage(),
        transition: Transition.fadeIn),
  ];
}
