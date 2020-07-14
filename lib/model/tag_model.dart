import 'package:flutter/material.dart';
import 'package:todo_app/entity/tag.dart';
import 'package:todo_app/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  List<Tag> allTagList;
  bool isUpdate;

  final tagRepo = TagRepository();

  TagModel() {
    _fetchAll();
  }

  Future setNewTag(TextEditingController newTag) async {
    if (newTag.text.isEmpty) {
      isUpdate = false;
      return;
    }
    if (allTagList.map((tag) => tag.tag).toList().contains(newTag.text)) {
      isUpdate = false;
      return;
    }
    isUpdate = true;
    await add(Tag(tag: newTag.text));
  }

  Future _fetchAll() async {
    allTagList = await tagRepo.getAllTag();
    notifyListeners();
  }

  Future add(Tag tag) async {
    tagRepo.insertTag(tag);
    _fetchAll();
  }

  Future update(Tag tag) async {
    await tagRepo.updateTag(tag);
    _fetchAll();
  }

  Future remove(Tag tag) async {
    await tagRepo.deleteTagById(tag.tagId);
    _fetchAll();
  }
}
