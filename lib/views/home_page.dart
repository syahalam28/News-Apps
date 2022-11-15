import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_project/controllers/news_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_project/utils/app_routes.dart';
import 'package:news_project/widgets/customAppBar.dart';
import 'package:news_project/widgets/news_card.dart';
import 'package:news_project/widgets/side_drawer.dart';
import '../constants/color_constants.dart';
import '../constants/size_constants.dart';
import '../constants/ui_constants.dart';
import 'package:flutter/foundation.dart';
import '../views/web_view_news.dart';
import '../utils/app_theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  // _HomePageState(this.isSwitched);
  NewsController newsController = Get.put(NewsController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer(newsController),
      appBar: customAppBar('Octo News', context, actions: [
        IconButton(
          onPressed: () {
            newsController.country.value = '';
            newsController.category.value = '';
            newsController.searchNews.value = '';
            newsController.channel.value = '';
            newsController.cName.value = '';
            newsController.getAllNews(reload: true);
            newsController.getBreakingNews(reload: true);
            newsController.update();
          },
          icon: const Icon(Icons.refresh),
        ),
        Switch(
          value: isSwitched,
          onChanged: (bool value) => setState(() => {
                isSwitched = value,
                print(isSwitched),
                isSwitched == false
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark())
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
            // Pencarian
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
                margin: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_18, vertical: Sizes.dimen_16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Sizes.dimen_8)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: Sizes.dimen_16),
                        child: TextField(
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search News"),
                          onChanged: (val) {
                            newsController.searchNews.value = val;
                            newsController.update();
                          },
                          onSubmitted: (value) async {
                            newsController.searchNews.value = value;
                            newsController.getAllNews(
                                searchKey: newsController.searchNews.value);
                            searchController.clear();
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          color: AppColors.burgundy,
                          onPressed: () async {
                            newsController.getAllNews(
                                searchKey: newsController.searchNews.value);
                            searchController.clear();
                          },
                          icon: const Icon(Icons.search_sharp)),
                    ),
                  ],
                ),
              ),
            ),
            // Message Before Crousel
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return controller.cName.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: Sizes.dimen_18),
                          child: Text(
                            "Trending Topics ${controller.cName.value.toUpperCase()}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: Sizes.dimen_20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
            vertical10,
            const Divider(),
            vertical10,
            // Crousel
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                      return controller.articleNotFound.value
                          ? const Center(
                              child: Text("Not Found",
                                  style: TextStyle(fontSize: 30)))
                          : controller.breakingNews.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Builder(builder: (BuildContext context) {
                                  try {
                                    return Banner(
                                      location: BannerLocation.topStart,
                                      message: 'Top Headlines',
                                      child: InkWell(
                                        onTap: () => Get.to(() =>
                                            WebViewNews(newsUrl: instance.url)),
                                        child: Stack(children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              instance.urlToImage ?? " ",
                                              fit: BoxFit.fill,
                                              height: double.infinity,
                                              width: double.infinity,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const SizedBox(
                                                    height: 200,
                                                    width: double.infinity,
                                                    child: Icon(Icons
                                                        .broken_image_outlined),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black12
                                                              .withOpacity(0),
                                                          Colors.black
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 10),
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        instance.title,
                                                        style: const TextStyle(
                                                            fontSize:
                                                                Sizes.dimen_16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )),
                                              )),
                                        ]),
                                      ),
                                    );
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                    return Container();
                                  }
                                });
                    }).toList(),
                  );
                }),
            vertical10,
            const Divider(),
            vertical10,
            // Message Before News
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return controller.cName.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: Sizes.dimen_18),
                          child: Text(
                            "News Update ${controller.cName.value.toUpperCase()}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: Sizes.dimen_20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
            vertical10,
            // Show News
            GetBuilder<NewsController>(
                init: NewsController(),
                builder: (controller) {
                  return controller.articleNotFound.value
                      ? const Center(
                          child: Text('Nothing Found'),
                        )
                      : controller.allNews.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                ListView.builder(
                                    // controller: controller.scrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.allNews.length,
                                    itemBuilder: (context, index) {
                                      index == controller.allNews.length - 1 &&
                                              controller.isLoading.isTrue
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const SizedBox();
                                      return InkWell(
                                          onTap: () => Get.to(() => WebViewNews(
                                              newsUrl: controller
                                                  .allNews[index].url)),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  NewsCard(
                                                    imgUrl: controller
                                                            .allNews[index]
                                                            .urlToImage ??
                                                        '',
                                                    desc: controller
                                                            .allNews[index]
                                                            .description ??
                                                        '',
                                                    title: controller
                                                        .allNews[index].title,
                                                    content: controller
                                                            .allNews[index]
                                                            .content ??
                                                        '',
                                                    postUrl: controller
                                                        .allNews[index].url,
                                                    source: controller
                                                            .allNews[index]
                                                            .source
                                                            .name ??
                                                        '',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ));
                                    }),
                                // if (controller.isLoadMoreRunning == true)
                                //   Padding(
                                //     padding:
                                //         EdgeInsets.only(top: 10, bottom: 40),
                                //     child: Center(
                                //       child: CircularProgressIndicator(),
                                //     ),
                                //   ),
                                if (controller.hasNextPage == false)
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 40),
                                    color: AppColors.burgundy,
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: Sizes.dimen_12,
                                        ),
                                        Center(
                                          child: Text(
                                            'You have fetched all of the content',
                                            style: TextStyle(
                                                color: AppColors.lightGrey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                }),
          ],
        ),
      ),
    );
  }
}


// class HomePage extends StatelessWidget {
//   bool isSwitched = false;
//   HomePage({Key? key}) : super(key: key);
//   NewsController newsController = Get.put(NewsController());
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: sideDrawer(newsController),
//       appBar: customAppBar('Octo News', context, actions: [
//         IconButton(
//           onPressed: () {
//             newsController.country.value = '';
//             newsController.category.value = '';
//             newsController.searchNews.value = '';
//             newsController.channel.value = '';
//             newsController.cName.value = '';
//             newsController.getAllNews(reload: true);
//             newsController.getBreakingNews(reload: true);
//             newsController.update();
//           },
//           icon: const Icon(Icons.refresh),
//         ),
//         Switch(
//           value: isSwitched,
//           // onChanged: (bool value) => setState(() => isSwitched = value),
//           onChanged: (bool value) {isSwitched[value] = !isSwitched[value]},
//           activeTrackColor: Colors.white,
//           activeColor: Colors.white,
//         ),
//       ]),
//       body: SingleChildScrollView(
//         // init: NewsController(),
//         controller: newsController.scrollController,
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Pencarian
//             Flexible(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
//                 margin: const EdgeInsets.symmetric(
//                     horizontal: Sizes.dimen_18, vertical: Sizes.dimen_16),
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(Sizes.dimen_8)),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       fit: FlexFit.tight,
//                       flex: 4,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: Sizes.dimen_16),
//                         child: TextField(
//                           controller: searchController,
//                           textInputAction: TextInputAction.search,
//                           decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Search News"),
//                           onChanged: (val) {
//                             newsController.searchNews.value = val;
//                             newsController.update();
//                           },
//                           onSubmitted: (value) async {
//                             newsController.searchNews.value = value;
//                             newsController.getAllNews(
//                                 searchKey: newsController.searchNews.value);
//                             searchController.clear();
//                           },
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       fit: FlexFit.tight,
//                       child: IconButton(
//                           padding: EdgeInsets.zero,
//                           color: AppColors.burgundy,
//                           onPressed: () async {
//                             newsController.getAllNews(
//                                 searchKey: newsController.searchNews.value);
//                             searchController.clear();
//                           },
//                           icon: const Icon(Icons.search_sharp)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Crousel
//             GetBuilder<NewsController>(
//                 init: NewsController(),
//                 builder: (controller) {
//                   return CarouselSlider(
//                     options: CarouselOptions(
//                         height: 200, autoPlay: true, enlargeCenterPage: true),
//                     items: controller.breakingNews.map((instance) {
//                       return controller.articleNotFound.value
//                           ? Center(
//                               child: Lottie.network(
//                                   'https://assets3.lottiefiles.com/packages/lf20_scgyykem.json'))
//                           : controller.breakingNews.isEmpty
//                               ? Center(
//                                   child: Lottie.network(
//                                       'https://assets5.lottiefiles.com/packages/lf20_eir9qziv.json'))
//                               : Builder(builder: (BuildContext context) {
//                                   try {
//                                     return Banner(
//                                       location: BannerLocation.topStart,
//                                       message: 'Top Headlines',
//                                       child: InkWell(
//                                         onTap: () => Get.to(() =>
//                                             WebViewNews(newsUrl: instance.url)),
//                                         child: Stack(children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             child: Image.network(
//                                               instance.urlToImage ?? " ",
//                                               fit: BoxFit.fill,
//                                               height: double.infinity,
//                                               width: double.infinity,
//                                               errorBuilder:
//                                                   (BuildContext context,
//                                                       Object exception,
//                                                       StackTrace? stackTrace) {
//                                                 return Card(
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10)),
//                                                   child: const SizedBox(
//                                                     height: 200,
//                                                     width: double.infinity,
//                                                     child: Icon(Icons
//                                                         .broken_image_outlined),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                           Positioned(
//                                               left: 0,
//                                               right: 0,
//                                               bottom: 0,
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     gradient: LinearGradient(
//                                                         colors: [
//                                                           Colors.black12
//                                                               .withOpacity(0),
//                                                           Colors.black
//                                                         ],
//                                                         begin:
//                                                             Alignment.topCenter,
//                                                         end: Alignment
//                                                             .bottomCenter)),
//                                                 child: Container(
//                                                     padding: const EdgeInsets
//                                                             .symmetric(
//                                                         horizontal: 5,
//                                                         vertical: 10),
//                                                     child: Container(
//                                                       margin: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 10),
//                                                       child: Text(
//                                                         instance.title,
//                                                         style: const TextStyle(
//                                                             fontSize:
//                                                                 Sizes.dimen_16,
//                                                             color: Colors.white,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     )),
//                                               )),
//                                         ]),
//                                       ),
//                                     );
//                                   } catch (e) {
//                                     if (kDebugMode) {
//                                       print(e);
//                                     }
//                                     return Container();
//                                   }
//                                 });
//                     }).toList(),
//                   );
//                 }),
//             vertical10,
//             const Divider(),
//             vertical10,
//             newsController.cName.isNotEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.only(left: Sizes.dimen_18),
//                     child: Obx(() {
//                       return Text(
//                         newsController.cName.value.toUpperCase(),
//                         textAlign: TextAlign.start,
//                         style: const TextStyle(
//                             fontSize: Sizes.dimen_20,
//                             fontWeight: FontWeight.bold),
//                       );
//                     }),
//                   )
//                 : const SizedBox.shrink(),
//             vertical10,
//             // Show News
//             GetBuilder<NewsController>(
//                 init: NewsController(),
//                 builder: (controller) {
//                   return controller.articleNotFound.value
//                       ? const Center(
//                           child: Text('Nothing Found'),
//                         )
//                       : controller.allNews.isEmpty
//                           ? Center(
//                               child: Lottie.network(
//                                   'https://assets5.lottiefiles.com/packages/lf20_miaaijas.json'))
//                           : Column(
//                               children: [
//                                 ListView.builder(
//                                     // controller: controller.scrollController,
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: controller.allNews.length,
//                                     itemBuilder: (context, index) {
//                                       index == controller.allNews.length - 1 &&
//                                               controller.isLoading.isTrue
//                                           ? Center(
//                                               child: Lottie.network(
//                                                   'https://assets5.lottiefiles.com/packages/lf20_miaaijas.json'),
//                                             )
//                                           : const SizedBox();
//                                       return InkWell(
//                                           onTap: () => Get.to(() => WebViewNews(
//                                               newsUrl: controller
//                                                   .allNews[index].url)),
//                                           child: Column(
//                                             children: [
//                                               Column(
//                                                 children: [
//                                                   NewsCard(
//                                                     imgUrl: controller
//                                                             .allNews[index]
//                                                             .urlToImage ??
//                                                         '',
//                                                     desc: controller
//                                                             .allNews[index]
//                                                             .description ??
//                                                         '',
//                                                     title: controller
//                                                         .allNews[index].title,
//                                                     content: controller
//                                                             .allNews[index]
//                                                             .content ??
//                                                         '',
//                                                     postUrl: controller
//                                                         .allNews[index].url,
//                                                     source: controller
//                                                             .allNews[index]
//                                                             .source
//                                                             .name ??
//                                                         '',
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ));
//                                     }),
//                                 if (controller.isLoadMoreRunning == true)
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.only(top: 10, bottom: 40),
//                                     child: Center(
//                                       child: Lottie.network(
//                                           'https://assets5.lottiefiles.com/temp/lf20_1Khaxw.json'),
//                                     ),
//                                   ),
//                                 if (controller.hasNextPage == false)
//                                   Container(
//                                     padding: const EdgeInsets.only(
//                                         top: 30, bottom: 40),
//                                     color: AppColors.burgundy,
//                                     child: Column(
//                                       children: const [
//                                         SizedBox(
//                                           height: Sizes.dimen_12,
//                                         ),
//                                         Center(
//                                           child: Text(
//                                             'You have fetched all of the content',
//                                             style: TextStyle(
//                                                 color: AppColors.lightGrey),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                               ],
//                             );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
