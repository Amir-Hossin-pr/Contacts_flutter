import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // implement dependencies
    Get.put(ContactsController());
  }
}
