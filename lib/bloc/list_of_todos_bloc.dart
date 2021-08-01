import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/bloc/bloc.dart';
import 'package:todo_app/model/list_of_todos.dart';
import 'package:todo_app/model/main_screen_title_data.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/services/list_of_todos_service.dart';
import 'package:todo_app/services/todo_service.dart';

class ListOfTodosBloc extends Bloc {
  final DateFormat _formatter = DateFormat("dd MMMM yyyy");
  final ListOfTodosService _listOfTodosService = ListOfTodosService();
  final TodoService _todoService = TodoService();

  final _mainScreenDataController = BehaviorSubject<MainScreenTitleTodoData>();
  final _drawerListsOfTodosConroller = BehaviorSubject<List<ListOfTodos>>();

  Stream<MainScreenTitleTodoData> get mainScreenDataStream =>
      _mainScreenDataController.stream;

  Stream<List<ListOfTodos>> get drawerListsOfTodosStream =>
      _drawerListsOfTodosConroller.stream;

  Function(MainScreenTitleTodoData) get changeMainScreenData =>
      _mainScreenDataController.sink.add;

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

    filterOverdueAndTodayTodos(true);
  }

  Future<List<ListOfTodos>> getTodoListsByPage() async {
    return await _listOfTodosService.getUsersListsByPage();
  }

  filterOverdueAndTodayTodos(bool publishData) {
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

    if (publishData)
      changeMainScreenData(
          MainScreenTitleTodoData("Today", [overdueTodos, todayTodos]));

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

  MainScreenTitleTodoData getStreamValues() {
    return _mainScreenDataController.value;
  }

  List<ListOfTodos> getListNames() {
    return _drawerListsOfTodosConroller.value;
  }

  showOverdueSection() {
    ListOfTodos overdueTodos = ListOfTodos(name: "Overdue", todos: []);
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    _mapOfTodos.forEach((key, value) {
      if (currentDate.isAfter(key)) {
        overdueTodos.todos.addAll(value);
      }
    });

    List<ListOfTodos> ret = [];

    _reformatPreviewItems(ret, overdueTodos.todos);

    changeMainScreenData(MainScreenTitleTodoData("Overdue", ret));
  }

  showTodaySection() {
    filterOverdueAndTodayTodos(true);
  }

  showUpcomingSection() {
    ListOfTodos upcomingTodos = ListOfTodos(name: "Upcoming", todos: []);
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    _mapOfTodos.forEach((key, value) {
      if (currentDate.isBefore(key)) {
        upcomingTodos.todos.addAll(value);
      }
    });

    List<ListOfTodos> ret = [];

    _reformatPreviewItems(ret, upcomingTodos.todos);

    changeMainScreenData(MainScreenTitleTodoData("Upcoming", ret));
  }

  List<int> getFinishedTodosMaxTodos() {
    int done = 0;
    int max = 0;

    _mapOfTodos.forEach((key, value) {
      max++;
      for (int i = 0; i < value.length; i++) {
        if (value[i].done) {
          done++;
        }
      }
    });

    return [done, max];
  }

  previewTodosOfSpecificList(int id, String listName) async {
    List<Todo> temp = await _todoService.getTodosByListID(id, null);

    List<ListOfTodos> ret = [];

    _reformatPreviewItems(ret, temp);

    changeMainScreenData(MainScreenTitleTodoData(listName, ret));
  }

  _reformatPreviewItems(List<ListOfTodos> ret, List<Todo> formattingValue) {
    formattingValue.forEach((element) {
      if (ret.isNotEmpty) {
        bool elementIsCreated = false;
        for (int i = 0; i < ret.length; i++) {
          if (ret[i].name == _formatter.format(element.date)) {
            elementIsCreated = true;
            ret[i].todos.add(element);
            break;
          }
        }

        if (!elementIsCreated) {
          ret.add(ListOfTodos(
              name: _formatter.format(element.date), todos: [element]));
        }
      }

      if (ret.isEmpty) {
        ret.add(ListOfTodos(
            name: _formatter.format(element.date), todos: [element]));
      }
    });
  }

  createTask(Todo todo, int listID) async {
    Todo newTodo = await _todoService.createTodo(
        Todo(date: todo.date, listName: todo.listName, todo: todo.todo),
        listID);

    List<Todo> currentTodos = _mapOfTodos[newTodo.date];
    if(currentTodos == null) {
      currentTodos = [todo];

    } else {
      currentTodos.add(newTodo);
    }

    _mapOfTodos[newTodo.date] = currentTodos;

    DateTime now = DateTime.now();
    if(newTodo.date.isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
      showTodaySection();
    }

    if(newTodo.date.isAfter(DateTime(now.year, now.month, now.day))) {
      showUpcomingSection();
    }
  }

  @override
  void dispose() {
    _mainScreenDataController.close();
    _drawerListsOfTodosConroller.close();
  }
}
