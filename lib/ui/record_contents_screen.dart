import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/entity/util.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/parts/input_record_contents_list_view.dart';
import '../entity/record_contents.dart';
import '../model/record_contents_model.dart';


class RecordContentsView extends StatelessWidget {
  final Record record;
  final List<RecordContents> contents;

  const RecordContentsView({
    Key key,
    @required this.record,
    @required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(record.title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("参加者設定"),
          color: Colors.amber[800],
          textColor: Colors.white,
          onPressed: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context){
                  return ParticipantSettingAlertDialog(record: record,);
                },
            );
          },
        ),
      ),
      floatingActionButton: InputRecordContentsButton(record: record,),
    );
  }
}

class ParticipantSettingAlertDialog extends StatelessWidget {
  final Record record;
  const ParticipantSettingAlertDialog({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordContentsModel>(context, listen: true);
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
                  child: ParticipantSettingAlertDialogDropdownButton(record: record),
                )
              ],
            ),
            NameList(model: model),
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
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class NameList extends StatelessWidget {
  const NameList({
    Key key,
    @required this.model,
  }) : super(key: key);

  final RecordContentsModel model;

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controllers = new List();
    return Container(
      height: 50.0 * int.parse(model.rangeValue),
      width: 150.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          _controllers.add(new TextEditingController());
          return TextField(
            controller: _controllers[index],
          );
          },
        itemCount: int.parse(model.rangeValue),
      ),
    );
  }
}

class ParticipantSettingAlertDialogDropdownButton extends StatelessWidget {
  final Record record;
  const ParticipantSettingAlertDialogDropdownButton({
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
      style: TextStyle(
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        model.changeNumberCount(record, int.parse(newValue));
        },
      items: rangeNumberCount
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value.toString()),
        );
      })
          .toList(),
    );
  }
}

class InputRecordContentsButton extends StatelessWidget {
  final Record record;

  const InputRecordContentsButton({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return InputRecordContentsAlertDialog(record: record,);
            }
        );
      },
    );
  }
}

class InputRecordContentsAlertDialog extends StatelessWidget {
  final Record record;
  const InputRecordContentsAlertDialog({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordContents = Provider.of<RecordContentsModel>(context, listen: true);
    return AlertDialog(
      title: Text('新規作成'),
      content: SingleChildScrollView(
        child: InputRecordContentsListView(list: recordContents.recordContentsList(record),),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        InputRecordContentsAlertDialogOkButton(list: recordContents.recordContentsList(record),),
      ],
    );
  }
}

class InputRecordContentsAlertDialogOkButton extends StatelessWidget {
  final List<RecordContents> list;
  const InputRecordContentsAlertDialogOkButton({
    Key key,
    @required this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(list.isEmpty){
      return Container();
    }
    return FlatButton(
        child: Text("OK"),
        onPressed: () {
//              recordContents.add(RecordContents(title: titleTextEditingController.text));
          Navigator.pop(context);
        }
    );
  }
}