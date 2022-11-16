import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_project/controllers/authC.dart';
import 'package:news_project/controllers/loginC.dart';
import 'package:news_project/views/Login_page.dart';
import 'package:news_project/views/onboarding_page.dart';
import './utils/app_routes.dart';
import './utils/app_theme.dart';
import 'package:get/get.dart';
import './views/home_page.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final loginC = Get.put(LoginC());
  final authC = Get.put(AuthC());
  // String? newsUrl;
  // const MyApp({Key? key}) : super(key: key);
  MyApp({Key? key}) : super(key: key);
  // HomePage homePage = (HomePage());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Agar auto login bisa berjalan maka harus menggunakan FutureBuilder
    return FutureBuilder(
      // Jika Koneksi dengan future yang isinya fungsi auto login berhasil dibuat maka tampilkan ini
      future: authC.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Izaaz News Application',
            theme: Themes.appTheme,
            // theme: homePage.isSwitched ? Themes.darkTheme : Themes.appTheme,
            // Melakukan pengecekan Login Jika auth true maka login berhasil jika tidak kembali ke halaman login
            // home: HomePage(),

            // initialRoute: AppRoutes.onBoard,
            home: authC.isAuth.isFalse ? OnboardingPage() : HomePage(),
            getPages: AppRoutes.routes,
          );
          // Obx(
          //   () =>
          //   // Isi return
          // );
        }
        // Jika tidak tampilkan ini
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
      // Isi return
    );
  }
}
