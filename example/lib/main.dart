import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition_view/page_transition_view.dart';

void main() => runApp(MyApp());

// ------ Root Widget ---------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Example",
      theme: ThemeData(
          primarySwatch: Colors.green,
          canvasColor: Colors.blue.shade100,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          platform: TargetPlatform.android),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Color> colors = [Colors.red,Colors.pink,Colors.yellow,Colors.blue,Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PageTransitionView Example"),),
      body: Container(
        color: Colors.black,
        child: PageTransitionView(
          direction: 0,
          toNext: (extra, scale, offset, rotation) {
            scale = Offset(1.0,1.0) * (extra);
            offset = Offset(500.0,700.0) * (1-extra);
            rotation = Rotation(2*pi*(1-extra));
            return [scale,offset,rotation];
          },
          toPrev: (extra, scale, offset, rotation) {
            scale = Offset(1.0,1.0) * (extra);
            offset = Offset(-500.0,-700.0) * (1-extra);
            rotation = Rotation(2*pi*extra);
            return [scale,offset,rotation];
          },
          itemCount: 10,
          itemBuilder: (c,index){
            return Container(color: colors[index%colors.length],child: Center(child: SizedBox(width: 100,height: 100,child: FittedBox(child: Text("$index")),),));
            },
          ),
        ),
    );
  }
}