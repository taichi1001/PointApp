import 'package:todo_app/dao/correspondence_name_record_dao.dart';
import 'package:todo_app/entity/correspondence_name_record.dart';

class CorrespondenceNameRecordRepository {
  final correspondenceNameRecordDao = CorrespondenceNameRecordDao();

  Future getAllCorrespondence() => correspondenceNameRecordDao.getAll();

  Future insertCorrespondence(CorrespondenceNameRecord correspondence) =>
      correspondenceNameRecordDao.create(correspondence);

  Future updateCorrespondence(CorrespondenceNameRecord correspondence) =>
      correspondenceNameRecordDao.update(correspondence);

  Future deleteCorrespondenceById(int id) =>
      correspondenceNameRecordDao.delete(id);

  //not use this
  Future deleteAllCorrespondence() => correspondenceNameRecordDao.deleteAll();
}
