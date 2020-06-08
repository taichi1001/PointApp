import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/util.dart';
import 'package:todo_app/model/record_model.dart';

class ParticipantSettingAlertDialog extends StatelessWidget {
  final Record record;
  const ParticipantSettingAlertDialog({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('参加者設定'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('人数'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _SettingParticipant(
                      record: record),
                )
              ],
            ),
            _NameList(record: record),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _NameList extends StatelessWidget {
  const _NameList({
    Key key,
    @required this.record,
  }) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controllers = new List();
    return Container(
      height: 50.0 * record.numberCount,
      width: 150.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          _controllers.add(new TextEditingController());
          return TextField(
            controller: _controllers[index],
          );
        },
        itemCount: record.numberCount,
      ),
    );
  }
}

class _SettingParticipant extends StatelessWidget {
  final Record record;
  const _SettingParticipant({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    return DropdownButton<String>(
      value: record.numberCount.toString(),
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        model.changeNumberCount(record, int.parse(newValue));
      },
      items: rangeNumberCount.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}