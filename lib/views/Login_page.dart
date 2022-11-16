import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_project/controllers/authC.dart';
import 'package:news_project/controllers/loginC.dart';
import 'package:news_project/views/web_view_news.dart';
import '../views/home_page.dart';
import 'package:get/get.dart';
import '../constants/size_constants.dart';

TextEditingController getUser = new TextEditingController();
TextEditingController getPass = new TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LoginForm extends StatelessWidget {
  final String newsUrl;
  final authC = Get.put(AuthC());
  LoginForm({Key? key, required this.newsUrl}) : super(key: key);
  final c = Get.find<LoginC>();
  final auth = Get.find<AuthC>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authC.autoLogin(),
        builder: (context, snapshot) {
          return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 3.0,
                  centerTitle: true,
                  toolbarHeight: Sizes.dimen_64,
                  title: const Text(
                    'Octo SignIn',
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    IconButton(
                      tooltip: "Back To News",
                      onPressed: () => Get.to(() => HomePage()),
                      icon: const Icon(Icons.home),
                    )
                  ],
                ),
                key: _scaffoldKey,
                body: ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.red[900],
                              fontSize: 32,
                              letterSpacing: 4.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Login to Explore Amazing Things',
                          style: TextStyle(
                              color: Colors.red[300],
                              fontSize: 18,
                              letterSpacing: 1.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            // Penggunaan Get untuk ambil data
                            controller: c.emailC,
                            // controller: getUser,
                            cursorColor: Colors.red,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 30.0, top: 20.0, bottom: 20.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 2.0),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.red,
                              ),
                              labelText: ('Username'),
                              labelStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => TextFormField(
                                  obscureText: c.hidden.value,
                                  controller: c.passwordC,
                                  // controller: getPass,
                                  cursorColor: Colors.red,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 30.0, top: 20.0, bottom: 20.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () => c.hidden.toggle(),
                                        icon: c.hidden.isTrue
                                            ? Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.red[900],
                                              )
                                            : Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Colors.red[900],
                                              )),
                                    labelText: ('Password'),
                                    labelStyle: TextStyle(color: Colors.red),
                                  )),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Obx(
                                  () => CheckboxListTile(
                                    value: c.remmemberme.value,
                                    onChanged: (value) =>
                                        c.remmemberme.toggle(),
                                    title: Text("Remember"),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () =>
                                      // Get.to(() => WebViewNews(newsUrl: newsUrl)),

                                      auth.login(
                                          c.emailC.text,
                                          c.passwordC.text,
                                          c.remmemberme.value,
                                          newsUrl),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}
