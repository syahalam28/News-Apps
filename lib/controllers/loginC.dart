import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginC extends GetxController {
  var hidden = true.obs;
  var remmemberme = false.obs;
  late TextEditingController emailC;
  late TextEditingController passwordC;

  @override
  void onInit() async {
    emailC = TextEditingController();
    passwordC = TextEditingController();
    // Karena sudah diletakan di main
    // await GetStorage.init();
    final box = GetStorage();
    if (box.read("dataUser") != null) {
      final data = box.read("dataUser") as Map<String, dynamic>;
      emailC.text = data['email'];
      passwordC.text = data['password'];
      remmemberme.value = data['rememberMe'];
    }
    super.onInit();
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }
}
