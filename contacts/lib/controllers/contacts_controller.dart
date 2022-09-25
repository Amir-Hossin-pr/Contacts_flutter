import 'dart:convert';

import 'package:contacts/models/contact.dart';
import 'package:contacts/utils/network.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

class ContactsController extends GetxController {
  String baseURL = 'https://retoolapi.dev/qgQGp3/contacts';

  List<Contact> contacts = <Contact>[];
  Rx<Contact> currentContact = Contact(fullName: '', mobileNo: '', id: 0).obs;

  Future<bool> insertContact(String fullName, String mobileNo) async {
    try {
      Contact contact = Contact(fullName: fullName, mobileNo: mobileNo, id: 0);
      var response = await post(Uri.parse(baseURL), body: contact.toJson());
      if (response.statusCode == 200) {
        var jsonDecode = json.decode(response.body);
        contacts.add(Contact.fromJson(jsonDecode));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateContact(int id, String fullName, String mobileNo) async {
    try {
      Contact contact = Contact(fullName: fullName, mobileNo: mobileNo, id: id);
      var response =
          await put(Uri.parse('$baseURL/$id'), body: contact.toJson());
      if (response.statusCode == 200) {
        var index = contacts.indexWhere((c) => c.id == id);
        if (index != -1) {
          contacts[index] = contact;
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteContact(int id) async {
    try {
      var response = await delete(Uri.parse('${baseURL}/${id}'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Contact>> getContacts() async {
    try {
      var response = await get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        contacts.clear();
        List jsonData = json.decode(response.body);
        for (var obj in jsonData) {
          contacts.add(Contact.fromJson(obj));
        }
      }
      return contacts;
    } catch (e) {
      return contacts;
    }
  }
}
