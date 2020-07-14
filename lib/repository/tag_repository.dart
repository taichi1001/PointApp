import 'package:todo_app/dao/tag_dao.dart';
import 'package:todo_app/entity/tag.dart';

class TagRepo {
  final tagDao = TagDao();

  Future getAllTag() => tagDao.getAll();

  Future insertTag(Tag tag) => tagDao.create(tag);

  Future updateTag(Tag tag) => tagDao.update(tag);

  Future deleteTagById(int id) => tagDao.delete(id);

  //not use this
  Future deleteAllTag() => tagDao.deleteAll();
}
