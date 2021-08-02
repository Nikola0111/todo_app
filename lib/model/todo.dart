import 'package:intl/intl.dart';

class Todo {
  int id;
  String todo;
  String listName;
  DateTime date;
  bool done;

  Todo({this.id, this.todo, this.listName, this.date, this.done});

  Todo.fromJSON({Map<String, dynamic> json, String nameOfTheList}) {
    id = json['id'];
    todo = json['name'];
    listName = nameOfTheList;
    date = DateFormat("yyyy-MM-dd").parse(json['due_date']);
    done = json['done'];
  }

  @override
  String toString() {
    return 'Todo{id: $id, todo: $todo, date: $date, done: $done, listName: $listName}';
  }
}