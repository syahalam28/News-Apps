import 'dart:convert';
import 'package:news_project/models/news_model.dart';
import '../constants/newsApi_constants.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// State Management
// Untuk mengubah halaman tanpa melakukan rendering ulangan halaman tersebut secara keseluruhan
// Menggunakan State Management GetXController
class NewsController extends GetxController {
  // for list view
  List<ArticleModel> allNews = <ArticleModel>[];
  // for carousel
  List<ArticleModel> breakingNews = <ArticleModel>[];
  ScrollController scrollController = ScrollController();
  RxBool articleNotFound = false.obs;
  RxBool isLoading = false.obs;
  RxBool hasNextPage = true.obs;
  Rx isLoadMoreRunning = false.obs;
  RxString cName = ''.obs;
  RxString country = ''.obs;
  RxString category = ''.obs;
  RxString channel = ''.obs;
  RxString searchNews = ''.obs;
  RxInt pageNum = 1.obs;
  RxInt pageSize = 10.obs;
  String baseUrl = "https://newsapi.org/v2/top-headlines?"; // ENDPOINT

  @override
  void onInit() {
    scrollController = ScrollController()..addListener(_scrollListener);
    getAllNews();
    getBreakingNews();
    super.onInit();
  }

  _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading.value = true;
      // hasNextPage.value = false;
      getAllNews();
      update();
    }
  }

  // function to load and display breaking news on to UI
  getBreakingNews({reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
    } else {
      country.value = '';
    }
    if (isLoading.value == true) {
      pageNum++;
      print("Loading Aktif Crousel");
    } else {
      breakingNews = [];

      pageNum.value = 1;
    }
    // default language is set to English
    /// ENDPOINT
    baseUrl =
        "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&languages=en&";
    // default country is set to indonesian
    baseUrl += country.isEmpty ? 'country=id&' : 'country=$country&';
    //baseApi += category.isEmpty ? '' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConstants.newsApiKey}';
    if (channel != '') {
      country.value = '';
      category.value = '';
      baseUrl =
          "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${NewsApiConstants.newsApiKey}";
    }
    print([baseUrl]);
    // calling the API function and passing the URL here
    getBreakingNewsFromApi(baseUrl);
  }

  // function to load and display all news and searched news on to UI
  getAllNews({searchKey = '', reload = false}) async {
    articleNotFound.value = false;

    if (!reload && isLoading.value == false) {
      // Set Next Page Agar tidak tampil terlebih dahulu baru ketika ada loading tampilkan
      print("Aktive reload and loading = false");
      hasNextPage.value = true;
    } else {
      // country.value = '';
      // category.value = '';
    }
    if (isLoading.value == true) {
      // pageNum += 1;
      pageNum++;
      print("Loading Aktif News");
    } else {
      allNews = [];

      pageNum.value = 1;
      print("Awal");
    }
    // ENDPOINT
    baseUrl = "https://newsapi.org/v2/top-headlines?pageSize=10&page=$pageNum&";
    // default country is set to Indonesian
    baseUrl += country.isEmpty ? 'country=id&' : 'country=$country&';
    // default category is set to Business
    baseUrl += category.isEmpty ? 'category=business&' : 'category=$category&';
    baseUrl += 'apiKey=${NewsApiConstants.newsApiKey}';
    if (channel != '') {
      country.value = '';
      category.value = '';
      baseUrl =
          "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=${NewsApiConstants.newsApiKey}";
    }
    if (searchKey != '') {
      var tanggal = new DateFormat('yyyy-dd-MM').format(DateTime.now());
      print(tanggal);
      country.value = '';
      category.value = '';
      cName.value = '';
      baseUrl =
          "https://newsapi.org/v2/everything?q=$searchKey&from=$tanggal&sortBy=popularity&apiKey=${NewsApiConstants.newsApiKey}";

      //
    }
    print(baseUrl);

    // calling the API function and passing the URL here
    getAllNewsFromApi(baseUrl);
  }

  // function to retrieve a JSON response for breaking news from newsApi.org
  getBreakingNewsFromApi(url) async {
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          breakingNews = [...breakingNews, ...newsData.articles];
          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            breakingNews = newsData.articles;
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }

  // function to retrieve a JSON response for all news from newsApi.org
  getAllNewsFromApi(url) async {
    //Creates a new Uri object by parsing a URI string.
    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      //Parses the string and returns the resulting Json object.
      NewsModel newsData = NewsModel.fromJson(jsonDecode(res.body));

      if (newsData.articles.isEmpty && newsData.totalResults == 0) {
        articleNotFound.value = isLoading.value == true ? false : true;
        isLoading.value = false;
        update();
      } else {
        if (isLoading.value == true) {
          // combining two list instances with spread operator
          allNews = [...allNews, ...newsData.articles];
          if (newsData.articles.isNotEmpty) {
            isLoadMoreRunning.value = true;
          } else if (newsData.articles.isEmpty) {
            hasNextPage.value = false;
          }

          update();
        } else {
          if (newsData.articles.isNotEmpty) {
            allNews = newsData.articles;
            // list scrolls back to the start of the screen
            if (scrollController.hasClients) scrollController.jumpTo(0.0);
            update();
          }
        }
        articleNotFound.value = false;
        isLoading.value = false;
        update();
      }
    } else {
      articleNotFound.value = true;
      update();
    }
  }
}
