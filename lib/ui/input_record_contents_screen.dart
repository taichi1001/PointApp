import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/name_model.dart';


class InputRecordContentsScreen extends StatelessWidget {
  final Record record;
  const InputRecordContentsScreen({
    @required this.record,
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
        appBar: AppBar(title: const Text('New Record'),),
        body: Column(
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: record.numberPeople,
              itemBuilder: (BuildContext context, int index) {
                _controllers.add(TextEditingController());
                return Row(
                  children: <Widget>[
                    Text(nameList[index].name),
                    TextField(
                      controller: _controllers[index],
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
    if(controllers.map((ctr) => ctr.text).toList().isNotEmpty){
      return RaisedButton(
        child: const Text('OK'),
        color: Colors.amber[800],
        textColor: Colors.white,
        onPressed: () {
        },
      );
    }else{
      return Container(); 
    }
  }
}