import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plot/flutter_plot.dart';

class Page2 extends StatelessWidget {
  List<Point> points;
  String functionSympol = 'Your Functoin is: f(x)= ', function = '';
  Page2(this.points, this.function);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          functionSympol + function,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: (Colors.yellow[700]),
      ),
      body: new Card(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              child: new Plot(
                height: 600.0,
                data: points,
                gridSize: new Offset(1, 1),
                style: new PlotStyle(
                  pointRadius: 2.0,
                  outlineRadius: 2.0,
                  primary: Colors.white,
                  secondary: Colors.orange,
                  textStyle: new TextStyle(
                    fontSize: 8.0,
                    color: Colors.blueGrey,
                  ),
                  axis: Colors.blueGrey[600],
                  gridline: Colors.blueGrey[100],
                ),
                padding: const EdgeInsets.fromLTRB(40.0, 12.0, 12.0, 40.0),
                xTitle: 'X Axis',
                yTitle: 'Y Axis',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
