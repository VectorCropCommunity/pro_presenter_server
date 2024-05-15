import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pro_presenter_server/assets.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: AssetImage(AssetImages.bg),
          fit: BoxFit.cover,
        ),
        Center(
          child: Text(
            "Server Running",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        )
      ],
    ));
  }
}
