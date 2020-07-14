import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/tag_model.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/tag.dart';

class SettingTagScreen extends StatelessWidget {
  const SettingTagScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('タグ設定')),
      body: Center(
        child: Column(
          children: const <Widget>[
            _SelectTag(),
            _NewTag(),
          ],
        ),
      ),
    );
  }
}

class _SelectTag extends StatelessWidget {
  const _SelectTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordModel = Provider.of<RecordModel>(context, listen: false);
    final record = Provider.of<Record>(context, listen: true);
    final tagModel = Provider.of<TagModel>(context, listen: true);

    return DropdownButton<String>(
      value: tagModel.getTagNameInId(record.tagId).tag,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        record.tagId = tagModel.getIdInTagName(value).tagId;
        recordModel.update(record);
      },
      items: tagModel.allTagList.map<DropdownMenuItem<String>>((Tag tag) {
        return DropdownMenuItem<String>(
          value: tag.tag,
          child: Text(tag.tag),
        );
      }).toList(),
    );
  }
}

class _NewTag extends StatelessWidget {
  const _NewTag({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller;
    return Consumer<TagModel>(
      builder: (context, tagModel, _) => Row(
        children: <Widget>[
          TextField(
            controller: controller,
          ),
          FlatButton(
            child: const Text('New'),
            onPressed: () {
              tagModel.setNewTag(controller);
            },
          )
        ],
      ),
    );
  }
}
