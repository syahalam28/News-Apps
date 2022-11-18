import 'dart:convert';

import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:news_project/utils/route_name.dart';
import 'package:news_project/views/fav.dart';
import 'package:news_project/views/home_page.dart';
import 'package:news_project/views/web_view_news.dart';
import 'package:restart_app/restart_app.dart';

class AuthC extends GetxController {
  Map<String, String> _dataUser = {
    'email': 'email@gmail.com',
    'password': 'admin'
  };
  var isAuth = false.obs;
  var isFavorite = false.obs;
  var products = {}.obs;
  var listRead = [].obs;
  var temp = [].obs;
  RxInt tempLengthGet = 0.obs;

  void dialogError(String msg) {
    Get.defaultDialog(title: "Something Wrong", middleText: msg);
  }

// Future diberikan pada method ini karena akan dijalankan pertama kali oleh future builder
  Future<void> autoLogin() async {
    final box = GetStorage();
    if (box.read("dataUser") != null) {
      final data = box.read("dataUser") as Map<String, dynamic>;
      login(data['email'], data['password'], data['rememberMe'], data["url"]);
      isAuth.value = true;
    }

    // Get.to(() => WebViewNews(newsUrl: newsUrl));
  }

// Simpan Data Login di Local Storage sama seperti provider
  void login(
      String email, String password, bool remmemberme, String newsUrl) async {
    if (email != '' && password != "") {
      if (GetUtils.isEmail(email)) {
        if (email == _dataUser['email'] && password == _dataUser['password']) {
          // Get.offAllNamed(RouteName.home);
          if (remmemberme) {
            // Karena sudah diletakan dimain
            // await GetStorage.init();
            // Simpan di storage
            final box = GetStorage();
            // Penamaan di localstorage
            box.write(
              'dataUser',
              {
                "email": email,
                "password": password,
                "rememberMe": remmemberme,
                "url": newsUrl
              },
            );
            isAuth.value = true;
          } else {
            // Hapus di storage
            final box = GetStorage();
            if (box.read('dataUser') != null) {
              box.erase();
            }
          }
          Get.to(() => WebViewNews(newsUrl: newsUrl));
        } else {
          dialogError("Username Or Password Not Valid");
        }
      } else {
        dialogError("Email Not Valid");
      }
    } else {
      dialogError("Input Required");
    }
  }

  // Method Logout
  void logout() {
    // Check jika remember me true maka ketika dispose email dan password akan tetap ada pada form

    // Hapus di storage
    final box = GetStorage();
    if (box.read('dataUser') != null) {
      box.erase();
    }
    Restart.restartApp(webOrigin: RouteName.home);
    // Get.to(() => HomePage());
    isAuth.value = false;
  }

// Method Favorites
  void favorites(
    String imageUrl,
    String title,
    String source,
    String newsUrl,
  ) async {
    final box = GetStorage('AppNameStorage');

    // products[{imageUrl, title, title, source, newsUrl}];
    // print(products);
    await box.write("dataFav", {
      "imageUrl": imageUrl,
      "title": title,
      "source": source,
      "newsUrl": newsUrl
    });
    // await box.write("dataFav", products);
    // if (box.read("dataFav") != null) {
    //   final data = box.read("dataFav") as Map<String, dynamic>;
    //   MyFavorite(
    //       imgUrl: data['imageUrl'],
    //       source: data['source'],
    //       title: data['title'],
    //       postUrl: data['newsUrl']);
    //   Get.to(() => MyFavorite(
    //       imgUrl: data['imageUrl'],
    //       source: data['source'],
    //       title: data['title'],
    //       postUrl: data['newsUrl']));
    // }
  }

  void Readfavorites() {
    final box = GetStorage('AppNameStorage');

    if (box.read("userFavorite") != null) {
      final data = box.read("userFavorite");
      // for (var i = 0; i < data.length; i++) {
      //   temp.add(data[i].split(";#+;"));
      // }

      // tempLengthGet.value = temp.length;
      Get.to(MyFavorite());

      // for (var i = 0; i < tempLengthGet.value; i++) {
      //   Get.to(() => MyFavorite(
      //       imgUrl: temp[i][0],
      //       source: temp[i][1],
      //       title: temp[i][2],
      //       postUrl: temp[i][3]));
      // }

      // print(temp[0][0]);

    }

    // if (box.read("userFavorite") != null) {
    //   final data = box.read("userFavorite") as Map<String, dynamic>;
    //   MyFavorite(
    //       imgUrl: data['imageUrl'],
    //       source: data['source'],
    //       title: data['title'],
    //       postUrl: data['newsUrl']);
    //   Get.to(() => MyFavorite(
    //       imgUrl: data['imageUrl'],
    //       source: data['source'],
    //       title: data['title'],
    //       postUrl: data['newsUrl']));
    // }
  }
}
