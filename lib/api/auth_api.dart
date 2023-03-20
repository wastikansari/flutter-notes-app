import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes_app/api/models/status.dart';
import 'package:notes_app/utiles/app_constants.dart';

class Registration {
  String url = AppConstants.BASE_URL;

  Future<Status> createUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201 ) {
      return Status.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<Status> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$url/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    print('dda sddddddddddddddddddd ${response.body}');
    if (response.statusCode == 200) {
      print('Login Successfully ${response.body} ');
      // print('Login Successfully ${response.body['access_token']} ');
      // if (response.body['access_token'] != null) {
      // authRepo.saveUserToken(response.body['access_token']);
      // }
      print(response.body);
      return Status.fromJson(jsonDecode(response.body));
    } else {
      return Status.fromJson(jsonDecode(response.body));
    }
  }
}
