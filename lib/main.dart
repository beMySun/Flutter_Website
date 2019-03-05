import 'package:flutter/material.dart';
import 'package:hello_flutter/models/global_model.dart';
import 'package:hello_flutter/HomePage.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  GlobalModel countModel = GlobalModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalModel>(
      model: countModel,
      child: new MaterialApp(
        title: 'Tracking Website',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
