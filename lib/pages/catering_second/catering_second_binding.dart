import 'package:get/get.dart';

import 'catering_second_logic.dart';

class CateringSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringSecondLogic());
  }
}
