import 'package:todo_app/dao/todo_dao.dart';
import 'package:todo_app/entity/record.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodos() => todoDao.getAll();

  Future insertTodo(Record todo) => todoDao.create(todo);

  Future updateTodo(Record todo) => todoDao.update(todo);

  Future deleteTodoById(int id) => todoDao.delete(id);

  //not use this sample
  Future deleteAllTodos() => todoDao.deleteAll();
}
