import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/ui/parts/input_record_contents_alert_dialog.dart';
import 'package:todo_app/ui/parts/participant_setting_alert_dialog.dart';

class RecordContentsView extends StatelessWidget {
  const RecordContentsView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Record>(
            builder: (context, record, _) => Text(record.title)),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 200, width: 200, child: _NameGrid()),
          Center(
            child: RaisedButton(
              child: const Text('参加者設定'),
              color: Colors.amber[800],
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const ParticipantSettingAlertDialog();
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const _InputRecordContentsButton(),
    );
  }
}

class _NameGrid extends StatelessWidget {
  const _NameGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameModel = Provider.of<NameModel>(context, listen: true);
    final record = Provider.of<Record>(context, listen: true);

    if (nameModel.getRecordNameList(record).isEmpty) {
      return const Text('名前を設定してください');
    }
    return GridView.builder(
        itemCount: nameModel.getRecordNameList(record).length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: nameModel.getRecordNameList(record).length,
        ),
        itemBuilder: (context, index) {
          return Text(nameModel.getRecordNameList(record)[index].name);
        });
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
