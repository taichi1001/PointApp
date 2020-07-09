import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/ui/parts/record_list_tile.dart';

class RecordListView extends StatelessWidget {
  const RecordListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    if (model.toRecordDisplay.isEmpty) {
      return const Center(child: Text('No Items'));
    }

    return ListView.builder(
      itemCount: model.toRecordDisplay.length,
      itemBuilder: (BuildContext context, int index) {
        final recordContentsModel =
            RecordContentsModel(record: model.toRecordDisplay[index]);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: model.toRecordDisplay[index]),
            ChangeNotifierProvider.value(
              value: recordContentsModel,
            ),
          ],
          child: const RecordListTile(),
        );
      },
    );
  }
}
