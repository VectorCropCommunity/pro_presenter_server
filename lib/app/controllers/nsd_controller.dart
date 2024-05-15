import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:nsd/nsd.dart';
import 'package:pro_presenter_server/app/controllers/common_controller.dart';

class NsdController extends GetxController {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Rxn<BaseDeviceInfo> device = Rxn<BaseDeviceInfo>();
  late Registration mainRegister;
  late HttpServer server;

  @override
  void onInit() {
    nsd();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    unregister(mainRegister);
    server.close();
    super.onClose();
  }

  nsd() async {
    await deviceInfo.deviceInfo.then((value) {
      print(value);
      device = Rxn<BaseDeviceInfo>(value);
    });
    mainRegister = await register(
      Service(
          name: '${device.value!.data["computerName"]}',
          type: '_presenter._tcp',
          port: 56000),
    );

    // print(mainRegister.service.host);

    runServer();
  }

  Future<void> runServer() async {
    // print(host.value);

    await HttpServer.bind(InternetAddress.anyIPv4, 3000).then(
      (value) {
        server = value;
        value.listen(
          (HttpRequest request) {
            String path = request.uri.path;

            switch (path) {
              case '/next':
                executer('tell application "System Events" to key code 124');
                // closeApp();
                request.response
                  ..headers.contentType =
                      ContentType("text", "plain", charset: "utf-8")
                  ..write("next")
                  ..close();
                break;
              case '/previous':
                executer('tell application "System Events" to key code 123');
                request.response
                  ..headers.contentType =
                      ContentType("text", "plain", charset: "utf-8")
                  ..write("previous")
                  ..close();
                break;
              case '/close':
                executer(
                    'tell application "System Events" to keystroke "q" using command down');
                request.response
                  ..headers.contentType =
                      ContentType("text", "plain", charset: "utf-8")
                  ..write("close")
                  ..close();
                break;
              case '/open':
                request.uri.queryParameters.keys.forEach((element) {
                  executer(
                    'tell application "/Applications/${element}" to activate',
                  );
                });
                request.response
                  ..headers.contentType = ContentType.text
                  ..write("object")
                  ..close();
                break;
              case '/apps':
                var jsonData = jsonEncode(
                    Get.find<CommonController>().getInstalledApplications());

                request.response
                  ..headers.contentType = ContentType.json
                  ..write(jsonData)
                  ..close();
                break;
              default:
                request.response.write("error");
            }
          },
        );
      },
    );
  }

  executer(String executable) async {
    await executeAppleScript(executable);
  }
}
