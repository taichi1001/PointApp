import 'package:todo_app/dao/record_contents_dao.dart';
import 'package:todo_app/entity/record_contents.dart';

class RecordContentsRepository {
  final recordContentsDao = RecordContentsDao();

  Future getAllRecordsContents() => recordContentsDao.getAll();

  Future insertRecordContents(RecordContents recordContents) =>
      recordContentsDao.create(recordContents);

  Future updateRecordContents(RecordContents recordContents) =>
      recordContentsDao.update(recordContents);

  Future deleteRecordContentsById(int id) => recordContentsDao.delete(id);

  //not use this sample
  Future deleteAllRecordsContents() => recordContentsDao.deleteAll();
}
