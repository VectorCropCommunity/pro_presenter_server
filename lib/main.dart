import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pro_presenter_server/app/controllers/nsd_controller.dart';
import 'package:window_manager/window_manager.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(400, 80),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    maximumSize: Size(400, 80),
    minimumSize: Size(400, 80),
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  Get.put(NsdController());

  

  runApp(
    GetMaterialApp(
      title: "Server",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
