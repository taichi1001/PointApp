import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/repository/todo_repository.dart';

class RecordModel with ChangeNotifier{
  List<Record> _allTodoList = [];
  List<Record> get allTodoList => _allTodoList;
  List<Record> get incompletedTodoList => _allTodoList.where((todo) => todo.isDone == false).toList();
  List<Record> get completedTodoList => _allTodoList.where((todo) => todo.isDone == true).toList();

  final TodoRepository repo = TodoRepository();

  RecordModel(){
    _fetchAll();
  }

  void _fetchAll() async {
    _allTodoList = await repo.getAllTodos();
    notifyListeners();
  }

  void add(Record todo) async {
    await repo.insertTodo(todo);
    _fetchAll();
  }

  void update(Record todo) async {
    await repo.updateTodo(todo);
    _fetchAll();
  }

  void toggleIsDone(Record todo) async {
    todo.isDone = !todo.isDone;
    update(todo);
  }

  void remove(Record todo) async {
    await repo.deleteTodoById(todo.id);
    _fetchAll();
  }

}