import 'package:get/get.dart';

import '../catering_first/catering_first_logic.dart';
import '../catering_second/catering_second_logic.dart';
import '../catering_third/catering_third_logic.dart';
import 'catering_tab_logic.dart';

class CateringTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CateringTabLogic());
    Get.lazyPut(() => CateringFirstLogic());
    Get.lazyPut(() => CateringSecondLogic());
    Get.lazyPut(() => CateringThirdLogic());
  }
}
