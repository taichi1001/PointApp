import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/ui/parts/input_record_contents_alert_dialog.dart';
import 'package:todo_app/ui/parts/participant_setting_alert_dialog.dart';

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
      body: Column(
        children: <Widget>[
          Container(
            height: 600.0,
            width: 500.0,
            child: Row(
              children: <Widget>[
                _NameGrid(contents: contents)
                        ]),
          ),
          RaisedButton(
            child: Text("参加者設定"),
            color: Colors.amber[800],
            textColor: Colors.white,
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ParticipantSettingAlertDialog(
                    record: record,
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: _InputRecordContentsButton(
        record: record,
      ),
    );
  }
}

class _NameGrid extends StatelessWidget {
  final List<RecordContents> contents;

  const _NameGrid({
    Key key,
    @required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameModel = Provider.of<NameModel>(context, listen: true);

    if(nameModel.getRecordNameList(contents).isEmpty){
      return Text('名前を設定してください');
    }
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index){
          return Text(nameModel.getRecordNameList(contents)[index].name);});
  }
}

class _InputRecordContentsButton extends StatelessWidget {
  final Record record;

  const _InputRecordContentsButton({
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
              return InputRecordContentsAlertDialog(
                record: record,
              );
            });
      },
    );
  }
}

