import 'package:contacts/models/contact.dart';
import 'package:get/state_manager.dart';

class ContactsController extends GetxController {
  List<Contact> contacts = <Contact>[];
  Rx<Contact> currentContact = Contact(fullName: '', mobileNo: '', id: 0).obs;

  Future<bool> insertContact(String fullName, String mobileNo) async {
    return true;
  }

  Future<bool> updateContact(int id, String fullName, String mobileNo) async {
    return true;
  }

  Future<bool> deleteContact(int id) async {
    return true;
  }

  Future<List<Contact>> getContacts() async {
    return [];
  }
}
