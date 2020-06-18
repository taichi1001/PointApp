import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/parts/input_record_contents_alert_dialog.dart';
import 'package:todo_app/ui/parts/participant_update_alert_dialog.dart';

class RecordContentsScreen extends StatelessWidget {
  final Record record;
  const RecordContentsScreen({
    @required this.record,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordContents = RecordContentsModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: recordContents,
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
            _DataTable(record: record)
          ],
        ),
        floatingActionButton: const _InputRecordContentsButton(),
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
      builder: (context, recordContents, _){
        return DataTable(
          columns: recordContents.getDataColumn(record),
          rows: recordContents.getDataRow(record),
        );
      },
    );
  }
}

class _InputRecordContentsButton extends StatelessWidget {
  const _InputRecordContentsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const InputRecordContentsAlertDialog();
          },
        );
      },
    );
  }
}
