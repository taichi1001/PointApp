import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/name.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/model/record_contents_model.dart';

class InputRecordContentsScreen extends StatelessWidget {
  final Record record;
  final RecordContentsModel recordContentsModel;
  const InputRecordContentsScreen({
    @required this.record,
    @required this.recordContentsModel,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameModel = Provider.of<NameModel>(context, listen: false);
    final nameList = nameModel.getRecordNameList(record);
    final List<TextEditingController> _controllers = [];
    return ChangeNotifierProvider.value(
      value: record,
      child: Scaffold(
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
                      Text(nameList[index].name),
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
              _OkButton(controllers: _controllers, nameList: nameList, record: record, recordContentsModel: recordContentsModel,),
            ],
          ),
        ),
      ),
    );
  }
}

class _OkButton extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<Name> nameList;
  final Record record;
  final RecordContentsModel recordContentsModel;

  const _OkButton({
    @required this.controllers,
    @required this.nameList,
    @required this.record,
    @required this.recordContentsModel,


    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return RaisedButton(
          child: const Text('OK'),
          color: Colors.amber[800],
          textColor: Colors.white,
          onPressed: () {
            recordContentsModel.addCount();
            recordContentsModel.addNewRecordContents(
                controllers, nameList);
            Navigator.pop(context);
          },
      );
    }
  }

