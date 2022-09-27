import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TranslateController extends GetxController {
  void changeLanguage(String lang) {
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
  }
}
