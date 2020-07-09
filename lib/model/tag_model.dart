import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/tag.dart';
import 'package:todo_app/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  Record record;
  List<Tag> _allTagList;
  bool _isUpdate;
  List<Tag> get allTagList => _allTagList;
  bool get isUpdate => _isUpdate;

  final tagRepo = TagRepository();

  TagModel() {
    _fetchAll();
  }

  Future setNewTag(TextEditingController newTag) async {
    if (newTag.text.isEmpty) {
      _isUpdate = false;
      return;
    }
    if (_allTagList.map((tag) => tag.tag).toList().contains(newTag.text)) {
      _isUpdate = false;
      return;
    }
    _isUpdate = true;
    await tagRepo.insertTag(Tag(tag: newTag.text));
    await _fetchAll();
  }

  Future _fetchAll() async {
    _allTagList = await tagRepo.getAllTag();
    notifyListeners();
  }

  Future add(Tag name) async {
    tagRepo.insertTag(name);
    _fetchAll();
  }

  Future update(Tag name) async {
    await tagRepo.updateTag(name);
    _fetchAll();
  }

  Future remove(Tag tag) async {
    await tagRepo.deleteTagById(tag.tagId);
    _fetchAll();
  }
}
