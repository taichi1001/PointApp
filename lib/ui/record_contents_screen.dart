import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/input_record_contents_screen.dart';
import 'package:todo_app/ui/parts/participant_update_alert_dialog.dart';

class RecordContentsScreen extends StatelessWidget {
  final Record record;
  const RecordContentsScreen({
    @required this.record,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordContentsModel = RecordContentsModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: recordContentsModel,
        ),
        ChangeNotifierProvider.value(
          value: record,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<Record>(
              builder: (context, record, _) => Text(record.title)),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: const Text('名前変更'),
                color: Colors.amber[800],
                textColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return ParticipantUpdateAlertDialog(record: record);
                    },
                  );
                },
              ),
            ),
            _DataTable(record: record),
            RaisedButton(
              child: const Text('New'),
              color: Colors.amber[800],
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return InputRecordContentsScreen(record: record);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DataTable extends StatelessWidget {
  final Record record;

  const _DataTable({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordContentsModel>(
      builder: (context, recordContentsModel, _) {
        return DataTable(
          columns: recordContentsModel.getDataColumn(record),
          rows: recordContentsModel.getDataRow(record),
        );
      },
    );
  }
}
