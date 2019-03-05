import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hello_flutter/models/global_model.dart';
import 'package:hello_flutter/Detail.dart';
import 'package:hello_flutter/models/TrackingData.dart';
import 'package:hello_flutter/models/TrackingResponse.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopee Express'),
          elevation: 0.0,
        ),
        body: new LoginHomePage());
  }
}

class LoginHomePage extends StatefulWidget {
  @override
  _LoginHomePageState createState() {
    return new _LoginHomePageState();
  }
}

class Dialog {
  final String title;
  Dialog({this.title});
}

Future<void> _dialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('title', textAlign: TextAlign.center),
        content: const Text('Invalid Tracking Number'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class _LoginHomePageState extends State<LoginHomePage> {
  bool _showLoading = false;

  TextEditingController trackingNumberController = TextEditingController();

  Future<Null> getTrackingData(context, model) async {
    // var testNUmber = 'ID1879105449711T';
    setState(() {
      _showLoading = true;
    });

    var trackingNumber = trackingNumberController.text;
    var url =
        'https://spx.test.shopee.co.id/api/v2/fleet_order/tracking/search?sls_tracking_number=${trackingNumber}';

    var trackReg = new RegExp(r"^[A-Z]{2}[0-9]{12,21}[A-Za-z0-9]{1,2}$");

    var isValidateTrackingNUmber = trackReg.hasMatch(trackingNumber);

    if (isValidateTrackingNUmber) {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _showLoading = false;
        });

        var responseBody =
            TrackingResponse.fromJson(json.decode(response.body));
        var responseData = responseBody.data;

        print(responseData);

        TrackingData data = new TrackingData.fromJson(responseData);

        model.updateData(data);
        model.updateTrackingStatus(data.currentStatus);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TrackingDetail()));
      }
    } else {
      _dialog(context);
      setState(() {
        _showLoading = false;
      });
    }
  }

  buildLogo() {
    return new Container(
      margin: const EdgeInsets.only(top: 140),
      constraints: new BoxConstraints.expand(height: 40),
      decoration: new BoxDecoration(
        color: Colors.transparent,
        image: new DecorationImage(
            image: new AssetImage('images/SPX_express_logo_white.png')),
      ),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
    );
  }

  buildTextField() {
    return new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: new EdgeInsets.all(16.0),
        height: 120,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Container(
            child: Stack(
          children: <Widget>[
            TextField(
              controller: trackingNumberController,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: 'Input your Tracking Number',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200]),
              onChanged: _textFieldChanged,
              autofocus: false,
              onSubmitted: _handleSubmission,
            ),
          ],
        )));
  }

  buildTrackButton(context) {
    return ScopedModelDescendant<GlobalModel>(builder: (context, child, model) {
      return new Container(
        margin: const EdgeInsets.only(top: 20),
        child: new Container(
          padding: new EdgeInsets.all(16.0),
          height: 90,
          child: RaisedButton(
            child: Text('Track',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                )),
            color: Colors.black,
            onPressed: () {
              getTrackingData(context, model);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      );
    });
  }

  buildFooter() {
    return new Container(
        child: new Stack(
          children: [
            new Positioned(
              child: new Container(
                child: new Text(
                    "Shopee Express Customer Service Phone: 150072 \n ©️2018 Shopee All Rights Reserved",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white)),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                ),
                padding: new EdgeInsets.all(16.0),
              ),
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
            ),
          ],
        ),
        width: 320.0,
        height: 240.0,
        color: Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> childs = [];

    final _loadingContainer = Container(
        constraints: BoxConstraints.expand(),
        color: Colors.black12,
        child: Center(
          child: Opacity(
            opacity: 1,
            child: SpinKitWave(
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ));

    final _mainConatiner = Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('images/m-home-bg.png'),
          ),
          gradient: RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.center,
              radius: 5),
          color: Colors.amber[900],
        ),
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Stack(
          children: <Widget>[
            Positioned(
                child: ListView(
              children: <Widget>[
                buildLogo(),
                buildTextField(),
                buildTrackButton(context),
                buildFooter()
              ],
            ))
          ],
        ));

    childs.add(_mainConatiner);

    if (_showLoading) {
      childs.add(_loadingContainer);
    }

    return Container(
      child: Stack(children: childs),
    );
  }
}

void _textFieldChanged(String str) {
  print('Value :' + str);
}

_handleSubmission(String str) {
  print('Value :' + str);
}
