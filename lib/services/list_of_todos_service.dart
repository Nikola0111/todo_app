import 'dart:convert';

import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/model/values.dart';
import 'package:http/http.dart' as http;

class ListOfTodosService {
  int _pageNumber = 1;

  Future<List<ListOfTodos>> getUsersListsByPage() async {
    List<ListOfTodos> ret = [];

    Uri uri = Uri.parse("${baseUrl}lists?page=$_pageNumber&per_page=10");

    http.Response response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });

    var json = jsonDecode(response.body);
    var list = json['data'] as List;
    ret = list.map((i) => ListOfTodos.fromJSON(i)).toList();

    print("There are the todos $ret");
    _pageNumber++;

    return ret;
  }

  Future<ListOfTodos> createList(ListOfTodos listOfTodos) async {
    Uri uri = Uri.parse("${baseUrl}lists");

    var body = jsonEncode({"name": listOfTodos.name});

    http.Response response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body);

    var json = jsonDecode(response.body);

    return ListOfTodos.fromJSON(json);
  }

  Future<ListOfTodos> updateListName(ListOfTodos listOfTodos) async {
    Uri uri = Uri.parse("${baseUrl}lists/${listOfTodos.id}");

    var body = jsonEncode({"name": listOfTodos.name});

    http.Response response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: body);

    var json = jsonDecode(response.body);

    return ListOfTodos.fromJSON(json);
  }


}
