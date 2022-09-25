import 'package:http/http.dart';

class Network {
  final String baseURL;

  Network({required this.baseURL});

  // static Uri uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts');

  Future<Response> callApi(
      String url, ApiCallType callType, Object? data) async {
    try {
      var uri = Uri.parse(baseURL + url);
      switch (callType) {
        case ApiCallType.post:
          return await post(uri);
        case ApiCallType.put:
          return await put(uri);
        case ApiCallType.delete:
          return await delete(uri);
        case ApiCallType.get:
          return await get(uri);
        default:
          return Response('No Action', 404);
      }
    } catch (e) {
      return Response('Exception', 500);
    }
  }

  // //? Contacts List
  // static List<Contact> contacts = [];

  // //! Get Data From Server
  // static Future<bool> getData() async {
  //   try {
  //     Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts');
  //     var request = await http.get(Network.uri);
  //     if (request.statusCode == 200) {
  //       contacts.clear();
  //       String response = request.body;
  //       List jsonDecode = json.decode(response);
  //       for (var jObject in jsonDecode) {
  //         contacts.add(Contact.fromJson(jObject));
  //       }
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // //* Post Data For Create New Contact
  // static Future<bool> postData(
  //     {required String mobileNo, required String fullName}) async {
  //   Contact contact = Contact(fullName: fullName, mobileNo: mobileNo, id: 0);

  //   try {
  //     var request = await http.post(Network.uri, body: contact.toJson());
  //     if (request.statusCode == 200 || request.statusCode == 201) {
  //       getData();
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // //* Pust Data For Edit Exist Contact
  // static Future<bool> pustData(
  //     {required String mobileNo,
  //     required String fullName,
  //     required int id}) async {
  //   Contact contact = Contact(fullName: fullName, mobileNo: mobileNo, id: id);
  //   Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts/$id');

  //   try {
  //     var request = await http.put(Network.uri, body: contact.toJson());
  //     if (request.statusCode == 200 || request.statusCode == 201) {
  //       getData();
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // //! Delete Customer
  // static Future<bool> deleteData(int id) async {
  //   Network.uri = Uri.parse('https://retoolapi.dev/qgQGp3/contacts/$id');
  //   try {
  //     var request = await http.delete(Network.uri);
  //     return request.statusCode == 200;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}

enum ApiCallType { post, get, put, delete }
