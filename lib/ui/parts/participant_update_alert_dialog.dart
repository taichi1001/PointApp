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
    final List<TextEditingController> _controllersTmp = [];
    for (final name in nameModel.getRecordNameList(record)) {
      final _controller = TextEditingController(text: name.name);
      final _controllerTmp = TextEditingController(text: name.name);
      _controllers.add(_controller);
      _controllersTmp.add(_controllerTmp);
    }

    return ChangeNotifierProvider.value(
      value: record,
      child: AlertDialog(
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
                nameModel.updateRecordName(_controllers, _controllersTmp);
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}