import 'package:flutter/material.dart';
import 'package:todo_app/entity/tag.dart';
import 'package:todo_app/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  List<Tag> allTagList;
  bool isUpdate;

  final tagRepo = TagRepo();

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

  Tag getTagNameInId(int id){
    return allTagList.where((tag) => tag.tagId == id).toList()[0];
  }

  Tag getIdInTagName(String tagName){
    return allTagList.where((tag) => tag.tag == tagName).toList()[0];
  }

  void notify(){
    notifyListeners();
  }

  Future _fetchAll() async {
    allTagList = await tagRepo.getAllTag();
    allTagList.insert(0, Tag(tagId: 0, tag: 'all'));
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
