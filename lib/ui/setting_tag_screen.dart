import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingTagScreen extends StatelessWidget {
  const SettingTagScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('タグ設定')),
      body: Center(
        child: Column(
          children: const <Widget>[
            _SelectTag(),
            _NewTag(),
          ],
        ),
      ),
    );
  }
}

class _SelectTag extends StatelessWidget {
  const _SelectTag({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _NewTag extends StatelessWidget {
  const _NewTag({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
