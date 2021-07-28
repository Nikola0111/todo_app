import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/model/static_strings.dart';
import 'package:todo_app/model/values.dart';

class AuthenticationService {
  Future<String> performLogin(String email, String password) async{
    Uri uri = Uri.parse("https://api-flutter-task.madduckcode.com/api/v1/auth/login");
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
}
