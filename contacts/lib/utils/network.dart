import 'dart:convert';

import 'package:contacts/models/contact.dart';
import 'package:http/http.dart' as http;

class Network {
  static Uri uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts');

  //? Contacts List
  static List<Contact> contacts = [];

  //! Get Data From Server
  static Future<bool> getData() async {
    try {
      var request = await http.get(Network.uri);
      if (request.statusCode == 200) {
        String response = request.body;
        List jsonDecode = json.decode(response);
        for (var jObject in jsonDecode) {
          contacts.add(jObject);
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //* Post Data For Create New Contact
  static Future<bool> postData(
      {required String mobileNo, required String fullName}) async {
    Contact contact = Contact(fullName: fullName, mobileNo: mobileNo);
    // http.post(Network.uri, body: contact.toJson()).then((response) {
    //   if (response.statusCode == 200) {}
    // });
    try {
      var reqeuest = await http.post(Network.uri, body: contact.toJson());
      if (reqeuest.statusCode == 200) {
        getData();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //* Pust Data For Edit Exist Contact
  static Future<bool> pustData(
      {required String mobileNo,
      required String fullName,
      required int id}) async {
    Contact contact = Contact(fullName: fullName, mobileNo: mobileNo);
    Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts/$id');

    try {
      var request = await http.put(Network.uri, body: contact.toJson());
      if (request.statusCode == 200) {
        getData();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  //! Delete Customer
  static Future<bool> deleteData(int id) async {
    Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts/$id');
    try {
      var request = await http.delete(Network.uri);
      return request.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
