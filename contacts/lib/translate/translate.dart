import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'fullName': 'Full Name',
          'mobileNo': 'Mobile Number',
          'save': 'Save'
        },
        'fa': {
          'fullName': 'نام و نام خانوادگی',
          'mobileNo': 'شماره موبایل',
          'save': 'دخیره'
        }
      };
}
