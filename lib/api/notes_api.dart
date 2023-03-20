
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/api/models/status.dart';

import 'package:notes_app/api/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utiles/app_constants.dart';

class NotesApi {
  String url = AppConstants.BASE_URL;
  String token = '';

  Future<UserModel> getNotesApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(AppConstants.TOKEN)!;
    print('token wastikkkkkk $token');

    final response = await http.get(
      Uri.parse(url + AppConstants.NOTES),
      headers: <String, String>{
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(data);
    
      return UserModel.fromJson(data);
    } else {
      return UserModel.fromJson(data);
    }
  }

  Future<Status> addNotes(title, description) async {
    print('addCardLink ddd wastik khan $title $description');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(AppConstants.TOKEN)!;

    final response = await http.post(
      Uri.parse(url + AppConstants.NOTES),
      headers: <String, String>{
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "title": title,
        "message": description,
      
      }),
    );
    if (response.statusCode == 200) {
      return Status.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<Status> updateNotes(title, description, cardId) async {
    print('updateCardLink ddd wastik khan $title, $description and $cardId');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(AppConstants.TOKEN)!;

    final response = await http.put(
      Uri.parse(url + AppConstants.NOTES + "/$cardId"),
      headers: <String, String>{
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "title": title,
        "message": description,
        
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return Status.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update cards.');
    }
  }

  Future<Status> deleteNotes(String cardId) async {
    print('deleteCardLink $cardId');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(AppConstants.TOKEN)!;
    final response = await http.delete(
      Uri.parse(url + AppConstants.NOTES + '/$cardId'),
      headers: <String, String>{
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${response.body}');
    if (response.statusCode == 201) {
      print(response.body);
      return Status.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load User');
    }
  }
}
