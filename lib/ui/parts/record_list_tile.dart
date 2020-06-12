import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/ui/record_contents_screen.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<Record>(
        builder: (context, record, _) =>
        ListTile(
          leading: const _CheckBoxButton(),
          title: Text(record.title),
          trailing: const _RemoveButton(),
          onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const RecordContentsView();
            })),
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
      builder: (context, record, _) =>
      FlatButton(
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
      builder: (context, record, child) =>
      FlatButton(
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          model.remove(record);
        },
      ),
    );
  }
}
