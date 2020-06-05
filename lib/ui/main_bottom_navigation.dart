import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/bottom_navigation_model.dart';
import 'package:todo_app/model/record_model.dart';

class MainBottomNavigation extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    final bottomNavigationModel = Provider.of<BottomNavigationModel>(context, listen: true);
    return Scaffold(
      body: Center(
        child: bottomNavigationModel.getSelectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Record'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            title: Text('Incompleted'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            title: Text('Completed'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomNavigationModel.selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          bottomNavigationModel.change(index);
        },
      ),
      floatingActionButton: AddTodoButton(),
    );
  }
}

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AddTodoDialog();
          }
        );
      },
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  AddTodoDialog({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final recordModel = Provider.of<RecordModel>(context, listen: true);
    final titleTextEditingController = TextEditingController();
    return AlertDialog(
      title: Text('新規作成'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: titleTextEditingController,
              decoration: InputDecoration(
                  labelText: 'Title'
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
            child: Text("OK"),
            onPressed: () {
              recordModel.add(Record(title: titleTextEditingController.text));
              Navigator.pop(context);
            }
        ),
      ],
    );
  }
}