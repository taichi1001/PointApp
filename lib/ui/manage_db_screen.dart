import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/manage_db_model.dart';

class ManageDBScreen extends StatelessWidget {
  const ManageDBScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage DB'),
      ),
      body: const DBListView(),
    );
  }
}

class DBListView extends StatelessWidget {
  const DBListView({Key key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ManageDBModel>(context, listen: true);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        RaisedButton(
              child: const Text('更新'),
              color: Colors.amber[800],
              textColor: Colors.white,
              onPressed: () => model.fetchAll()
            ),
        Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  Text(model.allRecordList[index].id.toString()),
                  Text(model.allRecordList[index].title.toString()),
                  Text(model.allRecordList[index].numberPeople.toString()),
                  Text(model.allRecordList[index].isDone.toString()),
                  ],
                );
            },
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  Text(model.allRecordContentsList[index].id.toString()),
                  Text(model.allRecordContentsList[index].recordId.toString()),
                  Text(model.allRecordContentsList[index].nameId.toString()),
                  Text(model.allRecordContentsList[index].count.toString()),
                  Text(model.allRecordContentsList[index].score.toString()),

                  ],
                );
            },
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  Text(model.allNameList[index].id.toString()),
                  Text(model.allNameList[index].name.toString()),
                  ],
                );
            },
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: <Widget>[
                  Text(model.allCorrespondenceList[index].id.toString()),
                  Text(model.allCorrespondenceList[index].nameId.toString()),
                  Text(model.allCorrespondenceList[index].recordId.toString()),
                  ],
                );
            },
          ),
        ),
      ],
    );
  }
}