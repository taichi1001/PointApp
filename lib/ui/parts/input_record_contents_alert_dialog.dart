import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/parts/input_record_contents_list_view.dart';

class InputRecordContentsAlertDialog extends StatelessWidget {
  const InputRecordContentsAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final record = Provider.of<Record>(context, listen: true);
    final recordContents =
        Provider.of<RecordContentsModel>(context, listen: true);
    return AlertDialog(
      content: SingleChildScrollView(
        child: InputRecordContentsListView(
          list: recordContents.getRecordContentsList(record),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        _OkButton(
          list: recordContents.getRecordContentsList(record),
        ),
      ],
    );
  }
}

class _OkButton extends StatelessWidget {
  final List<RecordContents> list;
  const _OkButton({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Container();
    }
    return FlatButton(
        child: const Text('OK'),
        onPressed: () {
//              recordContents.add(RecordContents(title: titleTextEditingController.text));
          Navigator.pop(context);
        });
  }
}
