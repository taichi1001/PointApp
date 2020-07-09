import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/ui/parts/record_list_view.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
        actions: const <Widget>[SettingButton()],
      ),
      body: const RecordListView(),
      floatingActionButton: const AddTodoButton(),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Text('a')));
      },
    );
  }
}

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AddTodoDialog();
            });
      },
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordModel = Provider.of<RecordModel>(context, listen: true);
    final titleTextEditingController = TextEditingController();
    return AlertDialog(
      title: const Text('新規作成'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: titleTextEditingController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
            child: const Text('OK'),
            onPressed: () {
              recordModel.add(Record(
                  date: DateTime.now(),
                  title: titleTextEditingController.text));
              Navigator.pop(context);
            }),
      ],
    );
  }
}
