import 'package:todo_app/dao/name_dao.dart';
import 'package:todo_app/entity/name.dart';

class NameRepository {
  final nameDao = NameDao();

  Future getAllName() => nameDao.getAll();

  Future insertName(Name name) =>
      nameDao.create(name);

  Future updateName(Name name) =>
      nameDao.update(name);

  Future deleteNameById(int id) => nameDao.delete(id);

  //not use this
  Future deleteAllName() => nameDao.deleteAll();
}