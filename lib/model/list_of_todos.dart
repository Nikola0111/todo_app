import 'package:todo_app/model/todo.dart';

class ListOfTodos {
  int id;
  String name;
  List<Todo> todos;

  ListOfTodos({this.id, this.name, this.todos});

  ListOfTodos.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  @override
  String toString() {
    return 'ListOfTodos{id: $id, name: $name, todos: $todos}';
  }
}