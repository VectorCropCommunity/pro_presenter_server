import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pro_presenter_server/app/controllers/nsd_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NsdController());
  
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
