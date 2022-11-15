import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import '../views/home_page.dart';
import '../views/onboarding_page.dart';

class AppRoutes {
  AppRoutes._();
  static const initial = '/homePage';
  static final routes = [
    GetPage(
        name: '/homePage',
        page: () => OnboardingPage(),
        transition: Transition.fadeIn),
  ];
}
