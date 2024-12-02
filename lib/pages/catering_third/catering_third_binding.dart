import 'package:get/get.dart';

import 'catering_third_logic.dart';

class CateringThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringThirdLogic());
  }
}
