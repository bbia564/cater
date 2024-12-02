import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cater_man_logic.dart';

class CaterManView extends GetView<PageLogic> {
  const CaterManView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.gerlach.value
              ? const CircularProgressIndicator(color: Colors.orange)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.okfdxzpm();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
