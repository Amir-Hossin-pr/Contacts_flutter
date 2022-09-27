import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'fullName': 'Full Name',
          'mobileNo': 'Mobile Number',
          'save': 'Save',
          'ChangeLang': 'Language Change',
          'ChangeLangMessage': 'Language Changed Successfuly',
          'mobileRequired': 'Mobile Number is required',
          'fullNameRequired': 'Full Name is required',
          'title': 'Contacts',
          'createNew': 'Create New Contact',
          'changeLang': 'Change Language'
        },
        'fa': {
          'fullName': 'نام و نام خانوادگی',
          'mobileNo': 'شماره موبایل',
          'save': 'دخیره',
          'ChangeLang': 'تغییر زبان',
          'ChangeLangMessage': 'زبان با موفقیت تغییر کرد',
          'mobileRequired': 'شماره موبایل الزامی می باشد',
          'fullNameRequired': 'نام و نام خانوادگی الزامی می باشد',
          'title': 'لیست مخاطبان',
          'createNew': 'افزودن مخاطب جدید',
          'changeLang': 'تغییر زبان'
        }
      };
}
