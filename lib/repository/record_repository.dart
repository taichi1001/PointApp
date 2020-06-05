import 'package:todo_app/dao/record_dao.dart';
import 'package:todo_app/entity/record.dart';

class RecordRepository {
  final recordDao = RecordDao();

  Future getAllRecords() => recordDao.getAll();

  Future insertRecord(Record todo) => recordDao.create(todo);

  Future updateRecord(Record todo) => recordDao.update(todo);

  Future deleteRecordById(int id) => recordDao.delete(id);

  //not use this sample
  Future deleteAllRecords() => recordDao.deleteAll();
}
