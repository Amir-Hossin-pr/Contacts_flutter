import 'dart:convert';

import 'package:contacts/models/contact.dart';
import 'package:http/http.dart' as http;

class Network {
  static Uri uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts');

  //? Contacts List
  static List<Contact> contacts = [];

//! Get Data From Server
  static void getData() async {
    http.get(Network.uri).then((response) {
      if (response.statusCode == 200) {
        contacts.clear();
        List jsonDecode = json.decode(response.body);
        for (var jobj in jsonDecode) {
          contacts.add(Contact.fromJson(jobj));
        }
      }
    });
  }

  //* Post Data For Create New Contact
  static void postData(
      {required String mobileNo, required String fullName}) async {
    Contact contact = Contact(fullName: fullName, mobileNo: mobileNo);
    http.post(Network.uri, body: contact.toJson()).then((response) {
      if (response.statusCode == 200) {}
    });
  }

  //* Pust Data For Edit Exist Contact
  static void pustData(
      {required String mobileNo,
      required String fullName,
      required int id}) async {
    Contact contact = Contact(fullName: fullName, mobileNo: mobileNo);
    Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts/$id');

    http.put(Network.uri, body: contact.toJson()).then((response) {
      if (response.statusCode == 200) {}
    });
  }

  //! Delete Customer
  static void deleteData(int id) async {
    Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts/$id');
    http.delete(Network.uri).then((response) {
      if (response.statusCode == 200) {
        getData();
      }
    });
  }
}
