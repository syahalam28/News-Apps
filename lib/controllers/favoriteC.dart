import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_project/models/article_model.dart';
import 'package:news_project/views/fav.dart';

class FavoriteController extends GetxController {
  // Add data to list data

  var listRead = [].obs;
  var temp = [].obs;
  RxInt tempLengthGet = 0.obs;

  // Function handle save localstorage
  void addFav(
    String imageUrl,
    String title,
    String source,
    String newsUrl,
  ) async {
    final box = GetStorage('AppNameStorage');

    listRead.add("$imageUrl;#+;$title;#+;$source;#+;$newsUrl");
    await box.write("userFavorite", listRead);

    if (await box.read("userFavorite") != null) {
      final data = box.read("userFavorite");
      for (var i = 0; i < data.length; i++) {
        temp.add(data[i].split(";#+;"));
      }
      //  temp.value.add(data[i].split(";#+;"));
      Get.to(MyFavorite());
      print(temp.length);

      // for (var i = 0; i < tempLengthGet.value; i++) {
      //   print(temp[i][0]);
      //   Get.to(() => MyFavorite(
      //       imgUrl: temp[i][0],
      //       source: temp[i][1],
      //       title: temp[i][2],
      //       postUrl: temp[i][3]));
      // }

      // print(temp[0][0]);

    }

    // temp['index'][0];
    // tempt['in'][0]

    // var listRead = box.read('userFavorite');
    // listRead!.add("$imageUrl;$title;$source;$newsUrl");
    // await box.write("userFavorite", listRead);

    // if (products.containsValue({imageUrl, title, source, newsUrl})) {
    //   // products[imageUrl, title, source, newsUrl] += 1;
    //   products[{
    //     'imageUrl': imageUrl,
    //     'title': title,
    //     'source': source,
    //     'newsUrl': newsUrl
    //   }] += 1;
    // } else {
    //   products[{
    //     'imageUrl': imageUrl,
    //     'title': title,
    //     'source': source,
    //     'newsUrl': newsUrl
    //   }] = 1;
    // }
    // final data = products as Map<dynamic, dynamic>;
    // print(data);
    // print(products);
    // MyFavorite(
    //     imgUrl: products['imgUrl'],
    //     source: products['source'],
    //     title: products['imgUrl'],
    //     postUrl: products['newsUrl']);
    // Get.to(() => MyFavorite(
    //     imgUrl: products['imageUrl'] ?? "",
    //     source: products['source'] ?? "",
    //     title: products['title'] ?? "",
    //     postUrl: products['newsUrl'] ?? ""));
    // Get.snackbar(
    //     "Favorites Added", "You Have added the ${title} to the favorites",
    //     snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  // get favorites => products;
}
