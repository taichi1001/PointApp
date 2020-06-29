import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/input_record_contents_screen.dart';
import 'package:todo_app/ui/parts/participant_update_alert_dialog.dart';
import 'package:todo_app/ui/parts/rank_rate_update_alert_dialog.dart';

class RecordContentsScreen extends StatelessWidget {
  const RecordContentsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Record>(
            builder: (context, record, _) => Text(record.title)),
      ),
      body: Consumer3<Record, RecordContentsModel, NameModel>(
        builder: (context, record, recordContentsModel, nameModel, _) {
          return Container(
            height: 800,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    const Text('編集モード'),
                    Switch(
                      value: record.isEdit,
                      onChanged: (bool value) {
                        record.changeIsEdit();
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Text('順位重複モード'),
                    Switch(
                      value: record.isDuplicate,
                      onChanged: (bool value) {
                        record.isDuplicate = value;
                        recordContentsModel.fetchAll();
                      },
                    ),
                  ],
                ),
                Center(
                  child: RaisedButton(
                    child: const Text('レート変更'),
                    color: Colors.amber[800],
                    textColor: Colors.white,
                    onPressed: () {
                      recordContentsModel.fetchAll();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(value: record),
                            ChangeNotifierProvider.value(
                                value: recordContentsModel),
                          ],
                          child: const RankRateUpdateAlertDialog(),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: RaisedButton(
                    child: const Text('名前変更'),
                    color: Colors.amber[800],
                    textColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(value: record),
                            ChangeNotifierProvider.value(
                                value: recordContentsModel),
                            ChangeNotifierProvider.value(
                                value: recordContentsModel.nameModel),
                          ],
                          child: const ParticipantUpdateAlertDialog(),
                        ),
                      );
                    },
                  ),
                ),
                const _DataTable(),
                RaisedButton(
                  child: const Text('New'),
                  color: Colors.amber[800],
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(value: record),
                            ChangeNotifierProvider.value(
                                value: recordContentsModel),
                          ],
                          child: const InputRecordContentsScreen(),
                        ),
                      ),
                    );
                  },
                ),
                const Text('順位'),
                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: nameModel.recordNameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          Text(recordContentsModel.scoreMap.keys
                              .toList()[index]),
                          Text(recordContentsModel.scoreMap.values
                              .toList()[index]
                              .toString()),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DataTable extends StatelessWidget {
  const _DataTable({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Record>(
      builder: (context, record, _) {
        if (record.isEdit) {
          return const _NormalDataTable();
        } else {
          return const _EditDataTable();
        }
      },
    );
  }
}

class _NormalDataTable extends StatelessWidget {
  const _NormalDataTable({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<Record, RecordContentsModel, NameModel>(
      builder: (context, record, recordContentsModel, nameModel, _) {
        return Container(
          height: 200,
          child: DataTable(
            columns: nameModel.recordNameList
                .map((name) => DataColumn(label: Text(name.name)))
                .toList(),
            rows: recordContentsModel.recordContentsPerCount
                .map(
                  (perCount) => DataRow(
                    cells: perCount
                        .map(
                          (recordContents) => DataCell(
                            ChangeNotifierProvider.value(
                              value: recordContents,
                              child: Consumer<RecordContents>(
                                builder: (context, recordContents, _) =>
                                    Text(recordContents.score.toString()),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _EditDataTable extends StatelessWidget {
  const _EditDataTable({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer3<Record, RecordContentsModel, NameModel>(
      builder: (context, record, recordContentsModel, nameModel, _) {
        return Container(
          height: 200,
          child: DataTable(
            columns: nameModel.recordNameList
                .map((name) => DataColumn(label: Text(name.name)))
                .toList(),
            rows: recordContentsModel.recordContentsPerCount
                .map(
                  (perCount) => DataRow(
                    cells: perCount
                        .map(
                          (recordContents) => DataCell(
                            ChangeNotifierProvider.value(
                              value: recordContents,
                              child: Consumer<RecordContents>(
                                builder: (context, recordContents, _) =>
                                    TextField(
                                  controller: TextEditingController(
                                      text: recordContents.score.toString()),
                                  onSubmitted: (String newText) {
                                    recordContents.updateScore(newText);
                                    recordContentsModel.recordContentsRepo
                                        .updateRecordContents(recordContents);
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
