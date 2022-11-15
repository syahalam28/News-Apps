import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:news_project/views/home_page.dart';
import '../widgets/cardOnboard.dart';

import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      title: "Looking for fast and accurate information?",
      subtitle:
          "Get information from various countries based on the category you like",
      image: LottieBuilder.asset("assets/animation/bgawal.json"),
      backgroundColor: const Color.fromARGB(255, 28, 28, 23),
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bgbelakang.json"),
    ),
    CardPlanetData(
      title: "Read news in millennial style",
      subtitle: "Reliable sources, accurate and actual",
      image: LottieBuilder.asset("assets/animation/bgdepandua.json"),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: LottieBuilder.asset("assets/animation/bgbelakangdua.json"),
    ),
    // CardPlanetData(
    //   title: "Start reading now",
    //   subtitle: "Lorem.",
    //   image: LottieBuilder.asset("assets/animation/bgawal.json"),
    //   backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
    //   titleColor: Colors.yellow,
    //   subtitleColor: Colors.white,
    //   background: LottieBuilder.asset("assets/animation/bgbelakang.json"),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
    );
  }
}
