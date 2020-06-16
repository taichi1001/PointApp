import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/util.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/model/name_model.dart';

class ParticipantSettingAlertScreen extends StatelessWidget {
  final Record record;
  const ParticipantSettingAlertScreen({
    @required this.record,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = [];
    final nameModel = Provider.of<NameModel>(context, listen: false);
    return ChangeNotifierProvider.value(
      value: record,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<Record>(
              builder: (context, record, _) => Text(record.title)),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text('人数'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _SettingNumberPeople(),
                      )
                    ],
                  ),
                  Consumer<Record>(
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
                ],
              ),
            ),
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
              ),
            Consumer<Record>(
              builder: (context, record, child) => FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  nameModel.setNewName(_controllers, record);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingNumberPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, _) => DropdownButton<String>(
        value: record.numberPeople.toString(),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          record.changeNumberPeople(int.parse(newValue));
          model.changeNumberPeople(record, int.parse(newValue));
        },
        items: rangeNumberCount.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
