import 'package:flutter/widgets.dart';

import '../model/todo.dart';

class TodoProvider extends ChangeNotifier{
  List<Todo> _todos = [];


  List<Todo> get todos => _todos;

  void addTodo(String title){
    _todos.add(Todo(title, false));
    notifyListeners();
  }
  void removeTodo(int index){
    _todos.removeAt(index);
    notifyListeners();
  }

  void editTodo(int index, String newTitle){
    _todos[index].title = newTitle;
    notifyListeners();
  }

  void toggleComplete(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  void sortTodos(bool completedFirst){
    _todos.sort((a,b){
      if (completedFirst){
        return a.isCompleted ? -1 : 1;
      }else{
        return a.isCompleted ? 1 : -1;
      }
    });
    notifyListeners();
  }


}