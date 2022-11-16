import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_project/controllers/authC.dart';
import 'package:news_project/controllers/news_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_project/utils/app_routes.dart';
import 'package:news_project/views/Login_page.dart';
import 'package:news_project/widgets/customAppBar.dart';
import 'package:news_project/widgets/news_card.dart';
import 'package:news_project/widgets/side_drawer.dart';
import '../constants/color_constants.dart';
import '../constants/size_constants.dart';
import '../constants/ui_constants.dart';
import 'package:flutter/foundation.dart';
import '../views/web_view_news.dart';
import '../utils/app_theme.dart';
import 'package:get_storage/get_storage.dart';

class MyFav extends StatefulWidget {
  MyFav({Key? key}) : super(key: key);

  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();

  @override
  State<MyFav> createState() => _MyFavState();
}

class _MyFavState extends State<MyFav> {
  bool isSwitched = false;

  // _MyFavState(this.isSwitched);
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();
  final auth = Get.find<AuthC>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Octo News', context, actions: [
        Switch(
          value: isSwitched,
          onChanged: (bool value) => setState(() => {
                isSwitched = value,
                print(isSwitched),
                isSwitched == false
                    ? Get.changeTheme(Themes.appTheme)
                    : Get.changeTheme(Themes.darkTheme)
              }),

          // onChanged: (bool value) {isSwitched[value] = !isSwitched[value]},
          activeTrackColor: Colors.black38,
          activeColor: Colors.black45,
        ),
      ]),
      body: SingleChildScrollView(
        // init: NewsController(),
        controller: newsController.scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vertical10,
            // Show News
            // Text(box.read('dataFav') ?? box.read('dataFav'))
          ],
        ),
      ),
    );
  }
}
