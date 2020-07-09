import 'package:todo_app/dao/tag_dao.dart';
import 'package:todo_app/entity/tag.dart';

class TagRepository {
  final tagDao = TagDao();

  Future getAllName() => tagDao.getAll();

  Future insertName(Tag tag) => tagDao.create(tag);

  Future updateName(Tag tag) => tagDao.update(tag);

  Future deleteNameById(int id) => tagDao.delete(id);

  //not use this
  Future deleteAllName() => tagDao.deleteAll();
}
