import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/model/Participant_model.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/parts/input_record_contents_list_view.dart';


class RecordContentsView extends StatelessWidget {
  final Record record;

  const RecordContentsView({
    Key key,
    @required this.record,
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
                  return ParticipantSettingAlertDialog();
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

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ParticipantModel>(context, listen: true);
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
                  child: ParticipantSettingAlertDialogDropdownButton(),
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

  final ParticipantModel model;

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

  String dropdownValue = 'One';
  ParticipantSettingAlertDialogDropdownButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ParticipantModel>(context, listen: true);
    return DropdownButton<String>(
      value: model.rangeValue,
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
        model.setRangeValue(newValue);
        },
      items: model.rangePeople
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
    final titleTextEditingController = TextEditingController();
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