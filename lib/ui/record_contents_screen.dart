import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/model/record_contents_model.dart';


class RecordContentsView extends StatelessWidget {
  final Record record;

  const RecordContentsView({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordContentsModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(record.title),
      ),
      body: Text(model.recordContentsList(record).toString()),
    );
  }
}

