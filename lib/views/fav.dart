import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
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

class MyFavorite extends StatelessWidget {
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();
  bool isSwitched = false;
  final auth = Get.find<AuthC>();
  final box = GetStorage();
  final String imgUrl, title, postUrl, source;
  MyFavorite(
      {Key? key,
      required this.imgUrl,
      required this.source,
      required this.title,
      required this.postUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        'Octo News',
        context,
      ),
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
            InkWell(
                onTap: () => Get.to(() => WebViewNews(newsUrl: postUrl)),
                child: Card(
                  elevation: Sizes.dimen_4,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Sizes.dimen_10))),
                  margin: const EdgeInsets.fromLTRB(
                      Sizes.dimen_16, 0, Sizes.dimen_16, Sizes.dimen_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(Sizes.dimen_10),
                              topRight: Radius.circular(Sizes.dimen_10)),
                          child: Stack(
                            children: [
                              Image.network(
                                imgUrl,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                                // if the image is null
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Icon(Icons.broken_image_outlined),
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Card(
                                  elevation: 0,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    child: Text(
                                      source,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                      vertical15,
                      Padding(
                        padding: const EdgeInsets.all(Sizes.dimen_6),
                        child: Text(
                          title,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Sizes.dimen_6),
                        child: Text(
                          "- " + source,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
