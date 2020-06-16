import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/name_model.dart';

class ParticipantUpdateAlertDialog extends StatelessWidget {
  final Record record;
  const ParticipantUpdateAlertDialog({
    @required this.record,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameModel = Provider.of<NameModel>(context, listen: false);
    final List<TextEditingController> _controllers = [];
    for (final name in nameModel.getRecordNameList(record)) {
      final _controller = TextEditingController(text: name.name);
      _controllers.add(_controller);
    }
    final _controllersTmp = _controllers;

    return ChangeNotifierProvider.value(
      value: record,
      child: AlertDialog(
        title: const Text('参加者設定'),
        content: SingleChildScrollView(
          child: Consumer<Record>(
            builder: (context, record, _) => Container(
              height: 50.0 * record.numberPeople,
              width: 150.0,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: record.numberPeople,
                itemBuilder: (BuildContext context, int index) {
                  _controllers.add(TextEditingController());
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
          Consumer<Record>(
            builder: (context, record, child) => FlatButton(
              child: const Text('OK'),
              onPressed: () {
                nameModel.updateRecordName(_controllers, _controllersTmp);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}