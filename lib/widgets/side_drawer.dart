import 'package:http/http.dart';
import 'package:news_project/controllers/authC.dart';
import 'package:news_project/controllers/loginC.dart';
import 'package:news_project/main.dart';
import 'package:news_project/utils/app_routes.dart';
import 'package:news_project/views/fav.dart';
import 'package:news_project/views/home_page.dart';

import '../constants/color_constants.dart';
import '../constants/newsApi_constants.dart';
import '../constants/size_constants.dart';
import '../constants/ui_constants.dart';
import '../controllers/news_controller.dart';
import '../utils/utils.dart';
import '../widgets/dropdown_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';

Drawer sideDrawer(NewsController newsController) {
  final c = Get.find<AuthC>();
  final authC = Get.put(AuthC());
  return Drawer(
    backgroundColor: AppColors.lightGrey,
    child: ListView(
      children: <Widget>[
        GetBuilder<NewsController>(
          builder: (controller) {
            return Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(66, 6, 5, 5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.dimen_10),
                    bottomRight: Radius.circular(Sizes.dimen_10),
                  )),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_18, vertical: Sizes.dimen_18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.cName.isNotEmpty
                      ? Text(
                          "Country: ${controller.cName.value.toUpperCase()}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15,
                  controller.category.isNotEmpty
                      ? Text(
                          "Category: ${controller.category.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                  vertical15,
                  controller.channel.isNotEmpty
                      ? Text(
                          "Channel: ${controller.channel.value.capitalizeFirst}",
                          style: const TextStyle(
                              color: AppColors.white, fontSize: Sizes.dimen_18),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
          init: NewsController(),
        ),
        // For Selecting the country
        // Membuat tampilan dropdown
        ExpansionTile(
          title: const Text("Select Country"),
          collapsedTextColor: Color.fromARGB(255, 51, 10, 15),
          collapsedIconColor: Color.fromARGB(255, 51, 10, 15),
          children: <Widget>[
            // Melakukan perulangan berdasarkan list dari country pada json utils
            for (int i = 0; i < listOfCountry.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = '';
                  newsController.country.value = listOfCountry[i]['code']!;
                  newsController.cName.value =
                      listOfCountry[i]['name']!.toUpperCase();
                  newsController.getAllNews();
                  newsController.getBreakingNews();
                },
                name: listOfCountry[i]['name']!.toUpperCase(),
              )
          ],
        ),

        /// For Selecting the Category
        ExpansionTile(
          collapsedTextColor: Color.fromARGB(255, 51, 10, 15),
          collapsedIconColor: Color.fromARGB(255, 51, 10, 15),
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text("Select Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.channel.value = '';
                    newsController.category.value = listOfCategory[i]['code']!;
                    newsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),

        /// For Selecting the Channel
        ExpansionTile(
          title: const Text("Select Channel"),
          collapsedTextColor: Color.fromARGB(255, 51, 10, 15),
          collapsedIconColor: Color.fromARGB(255, 51, 10, 15),
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = listOfNewsChannel[i]['code']!;
                  newsController.getAllNews();
                  newsController.cName.value = '';
                  newsController.category.value = '';
                  newsController.getBreakingNews();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              )
          ],
        ),
        const Divider(),
        ListTile(
          // onTap: () => Get.back(closeOverlays: true),
          onTap: () => Get.back(closeOverlays: true),
          trailing: const Icon(
            Icons.home,
            size: Sizes.dimen_28,
            color: Color.fromARGB(255, 51, 10, 15),
          ),
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: Sizes.dimen_16,
              color: Color.fromARGB(255, 51, 10, 15),
            ),
          ),
        ),

        ListTile(
          // onTap: () => Get.back(closeOverlays: true),
          onTap: () => c.Readfavorites(),
          trailing: const Icon(
            Icons.thumb_up,
            size: Sizes.dimen_28,
            color: Color.fromARGB(255, 51, 10, 15),
          ),
          title: const Text(
            "Home",
            style: TextStyle(
              fontSize: Sizes.dimen_16,
              color: Color.fromARGB(255, 51, 10, 15),
            ),
          ),
        ),

        const Divider(),
        c.isAuth.isFalse
            ? const Divider()
            : FloatingActionButton(
                backgroundColor: AppColors.burgundy,
                // Ketika di click ambil fungsi logout dari class AuthC
                onPressed: () => Get.find<AuthC>().logout(),
                child: Icon(
                  Icons.logout,
                  color: AppColors.lightGrey,
                ),
              )
      ],
    ),
  );
}
