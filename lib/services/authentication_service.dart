import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:todo_app/model/static_strings.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/model/values.dart';

class AuthenticationService {
  Future<String> performLogin(String email, String password) async{
    Uri uri = Uri.parse("${baseUrl}auth/login");
    var requestBody = {'email': email, 'password': password};

    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    var json = jsonDecode(response.body);
    accessToken = json['access_token'];

    if(accessToken == null) {
      return invalidCredentials;
    }

    return loginSuccess;
  }

  Future<User> authenticateMe() async{
    Uri uri = Uri.parse("${baseUrl}auth/me");
    http.Response response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    print("This is the response ${response.body}");

    try {
      var json = jsonDecode(response.body);
      User authedUser = User(id: json['id'], firstName: json['first_name'], lastName:json['last_name'], accessToken: json['access_token']);

      if(authedUser.firstName == null) {
        return null;
      } else {
        loggedUser = authedUser;
        return authedUser;
      }
    } on Exception {
      return null;
    }
  }
}
