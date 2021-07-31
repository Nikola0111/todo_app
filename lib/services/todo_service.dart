import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/model/values.dart';

class TodoService {
  getTodosByListID(int id, String listName) async {
    List<Todo> ret = [];

    Uri uri = Uri.parse("${baseUrl}lists/$id");

    http.Response response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    var json = jsonDecode(response.body);
    var list = json['tasks'] as List;

    ret = list
        .map((i) => Todo.fromJSON(json: i, nameOfTheList: listName))
        .toList();

    print("These are the todos for list $id : $ret");

    return ret;
  }

  changeTodoStatus(int id, bool status) async {
    Uri uri = Uri.parse("${baseUrl}tasks/$id/status");
    var body = {"done": status};

    await http.patch(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body));
  }

  deleteTodo(int id) async {
    Uri uri = Uri.parse("${baseUrl}tasks/$id");

    await http.delete(uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },);
  }
}
