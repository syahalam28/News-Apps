import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:news_project/controllers/authC.dart';
import 'package:news_project/controllers/loginC.dart';

import '../constants/ui_constants.dart';
import '../constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class NewsCard extends StatelessWidget {
// Method naviagte

  final String imgUrl, title, desc, content, postUrl, source;

  NewsCard(
      {Key? key,
      required this.imgUrl,
      required this.source,
      required this.desc,
      required this.title,
      required this.content,
      required this.postUrl});

  final data = <NewsCard>{};
  final authC = Get.put(AuthC());
  final c = Get.find<LoginC>();
  final auth = Get.find<AuthC>();
  final box = GetStorage("favorites");

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Sizes.dimen_4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10))),
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
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Text(
                          source,
                          style: Theme.of(context).textTheme.subtitle2,
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
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    FlutterShare.share(
                        title: title, text: desc, linkUrl: postUrl);
                  },
                  icon: Icon(Icons.share_outlined)),
              IconButton(
                  onPressed: () {
                    if (key == null) {
                      authC.favorites(imgUrl, title, source, postUrl);
                    }

                    // final alreadySaved = data.contains(NewsCard);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red[900],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
