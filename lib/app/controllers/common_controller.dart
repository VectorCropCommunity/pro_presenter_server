import 'dart:io';

import 'package:get/get.dart';

class CommonController extends GetxController {
  List<String> applications = [];
  
  @override
  void onInit() {
    List<String> applications = getInstalledApplications();

    print('List of installed applications:');
    for (var app in applications) {
      print(app);
    }
    super.onInit();
  }

  List<String> getInstalledApplications() {
    List<String> installedApplications = [];

    // Path to the Applications directory
    var applicationsDirectory = Directory('/Applications');

    // List contents of the Applications directory
    if (applicationsDirectory.existsSync()) {
      var apps = applicationsDirectory.listSync();

      for (var entity in apps) {
        if (entity is Directory) {
          // Get the name of the application from the directory
          var appName = entity.path.split('/').last;
          installedApplications.add(appName);
        }
      }
    } else {
      print('Applications directory not found');
    }

    return installedApplications;
  }
}

Future<void> executeAppleScript(String script) async {
  var process = await Process.start('osascript', ['-e', script]);
  var exitCode = await process.exitCode;

  print('AppleScript executed with exit code: $exitCode');
}
