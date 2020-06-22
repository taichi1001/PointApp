import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_contents_model.dart';

class InputRecordContentsScreen extends StatelessWidget {
  const InputRecordContentsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = [];
    return Consumer2<Record, RecordContentsModel>(
      builder: (context, record, recordContentsModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Record'),
          ),
          body: Container(
            height: 400,
            width: 300,
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: record.numberPeople,
                  itemBuilder: (BuildContext context, int index) {
                    _controllers.add(TextEditingController());
                    return Row(
                      children: <Widget>[
                        Text(recordContentsModel
                            .nameModel.recordNameList[index].name),
                        Container(
                          width: 200,
                          child: TextField(
                            controller: _controllers[index],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                _OkButton(controllers: _controllers),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OkButton extends StatelessWidget {
  final List<TextEditingController> controllers;

  const _OkButton({
    @required this.controllers,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordContentsModel>(
      builder: (context, recordContentsModel, _) => RaisedButton(
        child: const Text('OK'),
        color: Colors.amber[800],
        textColor: Colors.white,
        onPressed: () {
          recordContentsModel.addCount();
          recordContentsModel.addNewRecordContents(controllers);
          Navigator.pop(context);
        },
      ),
    );
  }
}
