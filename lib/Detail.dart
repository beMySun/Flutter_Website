import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:hello_flutter/models/global_model.dart';
import 'package:moment/moment.dart';

class TrackingDetail extends StatefulWidget {
  TrackingDetail({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TrackingDetailState createState() => new _TrackingDetailState();
}

class _TrackingDetailState extends State<TrackingDetail> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalModel>(
        builder: (context, child, model) {
          return Scaffold(
            appBar: new AppBar(
              title: new Text('Tracking Detail'),
              elevation: 0.0,
            ),
            body: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: new Column(
                    children: <Widget>[
                      buildTrackStatusBar(),
                      buildUserInfo(),
                      buildTrackingList(),
                      buildFooter()
                    ],
                  ),
                )
              ],
            ),
          );
        },
        rebuildOnChange: true);
  }

  buildTrackStatusBar() {
    return ScopedModelDescendant<GlobalModel>(
      builder: (context, child, model) {
        return Container(
            decoration: new BoxDecoration(
              color: Colors.green,
              gradient: RadialGradient(
                  colors: [Colors.greenAccent, Colors.green],
                  center: Alignment.centerLeft,
                  radius: 5),
            ),
            padding: new EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("${model.trackingStatus}",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                )
              ],
            ));
      },
    );
  }

  buildUserInfo() {
    return ScopedModelDescendant<GlobalModel>(
      builder: (context, child, model) {
        return new Container(
          padding: const EdgeInsets.all(
            10.0,
          ),
          margin: EdgeInsets.only(bottom: 15.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tracking Number',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    Text("${model.data.slsTrackingNumber}"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Recipient Name',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    Text("${model.data.recipientName}"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tel NUmber',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    Text("${model.data.phone}"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  buildTrackingList() {
    return ScopedModelDescendant<GlobalModel>(
      builder: (context, child, model) {
        return Expanded(
            child: ListView(
          children: buildListView(model),
        ));
      },
    );
  }

  buildListView(model) {
    List<Widget> widgets = [];
    var trackingList = model.data.trackingList;
    for (int i = 0; i < trackingList.length; i++) {
      widgets.add(new Padding(
        padding: new EdgeInsets.all(10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                                "${Moment(trackingList[i].timestamp * 1000).format('HH:mm:ss')}",
                                style: TextStyle(color: Colors.grey)),
                            Text(
                                "${Moment(trackingList[i].timestamp * 1000).format('yyyy-MM-dd')}",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${trackingList[i].status}"),
                        Text("${trackingList[i].message}"),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: i == trackingList.length - 1 ? 0 : 1,
                height: i == trackingList.length - 1 ? 0 : 30,
                margin: EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: null,
              )
            ],
          ),
        ),
      ));
    }
    return widgets;
  }

  buildFooter() {
    return new Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(
            "Shopee Express Customer Service Phone: 150072 \n ©️2018 Shopee All Rights Reserved",
            textAlign: TextAlign.center,
            style: new TextStyle(color: Colors.grey)));
  }
}
