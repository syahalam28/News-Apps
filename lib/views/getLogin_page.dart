import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_project/views/home_page.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp Untuk routing
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}
