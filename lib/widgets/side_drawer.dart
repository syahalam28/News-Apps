import 'package:http/http.dart';
import 'package:news_project/main.dart';
import 'package:news_project/utils/app_routes.dart';
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
  return Drawer(
    backgroundColor: AppColors.lightGrey,
    child: ListView(
      children: <Widget>[
        GetBuilder<NewsController>(
          builder: (controller) {
            return Container(
              decoration: const BoxDecoration(
                  color: AppColors.burgundy,
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
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          children: <Widget>[
            // Melakukan perulangan berdasarkan list dari country pada json utils
            for (int i = 0; i < listOfCountry.length; i++)
              drawerDropDown(
                onCalled: () {
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
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          title: const Text("Select Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              drawerDropDown(
                  onCalled: () {
                    newsController.category.value = listOfCategory[i]['code']!;
                    newsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),

        /// For Selecting the Channel
        ExpansionTile(
          title: const Text("Select Channel"),
          collapsedTextColor: AppColors.burgundy,
          collapsedIconColor: AppColors.burgundy,
          iconColor: AppColors.burgundy,
          textColor: AppColors.burgundy,
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              drawerDropDown(
                onCalled: () {
                  newsController.channel.value = listOfNewsChannel[i]['code']!;
                  newsController.getAllNews(
                      channel: listOfNewsChannel[i]['code']);
                  newsController.cName.value = '';
                  newsController.category.value = '';
                  newsController.update();
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
            color: AppColors.burgundy,
          ),
          title: const Text(
            "Home",
            style:
                TextStyle(fontSize: Sizes.dimen_16, color: AppColors.burgundy),
          ),
        ),
      ],
    ),
  );
}
