import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/ui/parts/record_list_tile.dart';

class RecordListView extends StatelessWidget {
  const RecordListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    if (model.allRecordContentsList.isEmpty) {
      return const Center(child: Text('No Items'));
    }

    return ListView.builder(
      itemCount: model.allRecordContentsList.length,
      itemBuilder: (BuildContext context, int index) =>
          ChangeNotifierProvider.value(
        value: model.allRecordContentsList[index],
        child: const RecordListTile(),
      ),
    );
  }
}
