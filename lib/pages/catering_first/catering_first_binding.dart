import 'package:get/get.dart';

import 'catering_first_logic.dart';

class CateringFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringFirstLogic());
  }
}
