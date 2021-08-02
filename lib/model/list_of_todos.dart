import 'package:intl/intl.dart';
import 'package:todo_app/model/todo.dart';

class ListOfTodos {
  int id;
  String name;
  List<Todo> todos;
  DateTime dateOfCreation;

  ListOfTodos({this.id, this.name, this.todos, this.dateOfCreation});

  ListOfTodos.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateOfCreation = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(json['created_at']);
  }


  DateTime _formatDate(String jsonDate) {
    List<String> dateValue = jsonDate.split("-");

    return DateTime(int.parse(dateValue[0]), int.parse(dateValue[1]), int.parse(dateValue[2]));
  }

  @override
  String toString() {
    return 'ListOfTodos{id: $id, name: $name, todos: $todos}';
  }
}