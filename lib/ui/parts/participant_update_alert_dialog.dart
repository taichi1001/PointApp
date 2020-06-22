import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_contents_model.dart';

class ParticipantUpdateAlertDialog extends StatelessWidget {
  const ParticipantUpdateAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = [];
    final List<TextEditingController> _controllersTmp = [];

    return Consumer2<Record, RecordContentsModel>(
      builder: (context, record, recordContentsModel, _) {
      for (final name in recordContentsModel.nameModel.recordNameList) {
        final _controller = TextEditingController(text: name.name);
        final _controllerTmp = TextEditingController(text: name.name);
        _controllers.add(_controller);
        _controllersTmp.add(_controllerTmp);
      }
      
      return AlertDialog(
        title: const Text('名前変更'),
        content: SingleChildScrollView(
          child: Consumer<Record>(
            builder: (context, record, _) => Container(
              height: 50.0 * record.numberPeople,
              width: 150.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: record.numberPeople,
                itemBuilder: (BuildContext context, int index) {
                  return TextField(
                    controller: _controllers[index],
                  );
                },
              ),
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
              child: const Text('OK'),
              onPressed: () {
                recordContentsModel.nameModel.updateRecordName(_controllers, _controllersTmp);
                Navigator.pop(context);
              },
            ),
        ],
      );
      },
    );
  }
}