import 'package:rxdart/rxdart.dart';
import 'package:todo_app/bloc/bloc.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/services/list_of_todos_service.dart';
import 'package:todo_app/services/todo_service.dart';

class ListOfTodosBloc extends Bloc {
  final ListOfTodosService _listOfTodosService = ListOfTodosService();
  final TodoService _todoService = TodoService();

  final _previewListOfTodosController = BehaviorSubject<List<ListOfTodos>>();
  final _drawerListsOfTodosConroller = BehaviorSubject<List<ListOfTodos>>();

  Stream<List<ListOfTodos>> get previewListOfTodosStream =>
      _previewListOfTodosController.stream;

  Stream<List<ListOfTodos>> get drawerListsOfTodosStream =>
      _drawerListsOfTodosConroller.stream;

  Function(List<ListOfTodos>) get changePreviewListOfTodos =>
      _previewListOfTodosController.sink.add;

  Function(List<ListOfTodos>) get changeDrawerListsOfTodos =>
      _drawerListsOfTodosConroller.sink.add;

  Map _mapOfTodos = Map<DateTime, List<Todo>>();

  getListsAndTodos() async {
    Map todos = Map<DateTime, List<Todo>>();
    List<ListOfTodos> todoList = await getTodoListsByPage();

    changeDrawerListsOfTodos(todoList);

    for (int i = 0; i < todoList.length; i++) {
      List<Todo> temp =
          await _todoService.getTodosByListID(todoList[i].id, todoList[i].name);

      temp.forEach((element) {
        if (!element.done) {
          if (todos.containsKey(element.date)) {
            List<Todo> existingTodos = todos[element.date];
            existingTodos.add(element);

            todos[element.date] = existingTodos;
          }

          if (!todos.containsKey(element.date)) {
            List<Todo> newTodosValue = [];
            newTodosValue.add(element);

            todos[element.date] = newTodosValue;
          }
        }
      });
    }

    _mapOfTodos = todos;

    changePreviewListOfTodos(filterOverdueAndTodayTodos());
  }

  Future<List<ListOfTodos>> getTodoListsByPage() async {
    return await _listOfTodosService.getUsersListsByPage();
  }

  List<ListOfTodos> filterOverdueAndTodayTodos() {
    ListOfTodos overdueTodos = ListOfTodos(name: "Overdue", todos: []);
    ListOfTodos todayTodos = ListOfTodos(name: "Today", todos: []);

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    _mapOfTodos.forEach((key, value) {
      if (currentDate.isAtSameMomentAs(key)) {
        todayTodos.todos.addAll(value);
      }

      if (currentDate.isAfter(key)) {
        overdueTodos.todos.addAll(value);
      }
    });

    return [overdueTodos, todayTodos];
  }

  ListOfTodos filterUpcomingTodos() {
    ListOfTodos upomingTodos = ListOfTodos(name: "Upcoming", todos: []);

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    _mapOfTodos.forEach((key, value) {
      if (currentDate.isBefore(key)) {
        upomingTodos.todos.addAll(value);
      }
    });

    return upomingTodos;
  }

  List<ListOfTodos> getStreamValues() {
    return _previewListOfTodosController.value;
  }

  showOverdueSection() {

  }

  showTodaySection() {

  }

  showUpcomingSection() {

  }

  @override
  void dispose() {
    _previewListOfTodosController.close();
    _drawerListsOfTodosConroller.close();
  }
}
