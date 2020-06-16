import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/ui/participant_setting_screen.dart';

import '../../model/name_model.dart';
import '../record_contents_screen.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NameModel>(context, listen: false);
    return Card(
      child: Consumer<Record>(
        builder: (context, record, _) => ListTile(
          leading: const _CheckBoxButton(),
          title: Text(record.title),
          trailing: const _RemoveButton(),
          onTap: () => {
            if (model.getRecordNameList(record).isEmpty)
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ParticipantSettingScreen(record: record);
                    },
                  ),
                ),
              }
            else
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return RecordContentsScreen(record: record);
                    },
                  ),
                ),
              }
          },
        ),
      ),
    );
  }
}

class _CheckBoxButton extends StatelessWidget {
  const _CheckBoxButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, _) => FlatButton(
        child: record.isDone
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank),
        onPressed: () {
          model.toggleIsDone(record);
        },
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, child) => FlatButton(
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          model.remove(record);
        },
      ),
    );
  }
}
