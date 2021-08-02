import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/model/values.dart';

class TodoService {
  DateFormat _formatter = DateFormat("yyyy-MM-dd");

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

  Future<bool> changeTodoStatus(int id, bool status) async {
    Uri uri = Uri.parse("${baseUrl}tasks/$id/status");
    var body = {"done": status};

    try {
      await http.patch(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(body));
    } on Exception {
      return false;
    }

    return true;
  }

  Future<bool> updateTodo(int id, String name) async {
    Uri uri = Uri.parse("${baseUrl}tasks/$id");
    var body = {"name": name};

    try {
      await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(body));
    } on Exception {
      return false;
    }

    return true;
  }

  deleteTodo(int id) async {
    Uri uri = Uri.parse("${baseUrl}tasks/$id");

    await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
  }

  createTodo(Todo newTodo, int listID) async {
    Uri uri = Uri.parse("${baseUrl}lists/$listID/tasks");
    var body = {
      "name": newTodo.todo,
      "due_date":
          _formatter.format(newTodo.date)
    };

    Todo databaseTodo;
    http.Response response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body));

    var json = jsonDecode(response.body);

    try{
      databaseTodo =
          Todo.fromJSON(json: json, nameOfTheList: newTodo.listName);
    } on Exception {
      return Todo();
    }

    return databaseTodo;
  }
}
