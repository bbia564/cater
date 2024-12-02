import 'package:get/get.dart';

import 'cater_man_logic.dart';

class CaterManBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
