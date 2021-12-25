//import 'dart:html';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Page2.dart';
//import 'package:sampleproject/point.dart';

class Page1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _functionController = TextEditingController();
  TextEditingController _minXController = TextEditingController();
  TextEditingController _maxXController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task1',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: (Colors.yellow[700]),
      ),
      backgroundColor: Colors.grey[850],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 250,
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-+/*^x]')),
                    ],
                    controller: _functionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Your Funciton';
                      } else if (validate(value) == false)
                        return 'Please Enter Valid Function';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Your Function F(x)",
                        labelStyle: TextStyle(
                          color: Colors.yellow[700],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter The Function'),
                    style: TextStyle(
                      color: Colors.yellow[700],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 250,
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    ],
                    controller: _minXController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Your min x';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Min Of X",
                        labelStyle: TextStyle(
                          color: Colors.yellow[700],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter The Minimum Value Of X'),
                    style: TextStyle(
                      color: Colors.yellow[700],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 250,
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    ],
                    controller: _maxXController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Your max x';
                      } else if (double.parse(value) <=
                          double.parse(_minXController.text))
                        return 'Max X MUST be greater than Min X';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Max Of X",
                        labelStyle: TextStyle(
                          color: Colors.yellow[700],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Enter The Maximum Value Of X'),
                    style: TextStyle(
                      color: Colors.yellow[700],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int maxX = int.parse(_maxXController.text);
                        int minX = int.parse(_minXController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Page2(
                                    getPoints(
                                        _functionController.text, minX, maxX),
                                    _functionController.text)));
                      }
                    },
                    child: Text(
                      'Plot',
                      style: TextStyle(color: Colors.yellow[700]),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.yellow))))),
              ],
            ),
          ),
        ],
      ),
    );
  }

//This method check if the function is correct or not
  bool validate(String function) {
    String signs = '+/*-^';
    if (signs.contains(function[function.length - 1]) == true) return false;

    if (signs.contains(function[0]) == true) return false;

    for (int i = 0; i < function.length - 1; i++) {
      if (signs.contains(function[i]) == true &&
          signs.contains(function[i + 1])) return false;
      if (function[i] == 'x' && function[i + 1] == 'x') return false;
    }

    return true;
  }

// This method removes the X and replace it with the x coordinate
  Queue remove_X(int x, Queue Function) {
    Queue res = new Queue();
    for (int i = 0; i < Function.length; i++) {
      if (Function.elementAt(i) == 'x') {
        res.add(x.toString());
      } else
        res.add(Function.elementAt(i));
    }

    return res;
  }

//after this method the fucntion will contain '+' adn '-' signs only
  Queue simplifiedFun(Queue function) {
    Queue res = new Queue();
    Queue<double> numb = new Queue();
    Queue sin = new Queue();

    for (int i = 0; i < function.length; i++) {
      if (function.elementAt(i) == '+' ||
          function.elementAt(i) == '/' ||
          function.elementAt(i) == '-' ||
          function.elementAt(i) == '^' ||
          function.elementAt(i) == '*') {
        sin.add(function.elementAt(i));
      } else {
        numb.add(double.parse(function.elementAt(i)));
      }
    }

    res = removeSign(numb, sin, '^');
    numb.clear();
    sin.clear();

    for (int i = 0; i < res.length; i++) {
      if (res.elementAt(i) == '+' ||
          res.elementAt(i) == '/' ||
          res.elementAt(i) == '-' ||
          res.elementAt(i) == '*') {
        sin.add(res.elementAt(i));
      } else {
        numb.add(double.parse(res.elementAt(i)));
      }
    }
    res.clear();
    res = removeSign(numb, sin, '*');
    numb.clear();
    sin.clear();

    for (int i = 0; i < res.length; i++) {
      if (res.elementAt(i) == '+' ||
          res.elementAt(i) == '/' ||
          res.elementAt(i) == '-') {
        sin.add(res.elementAt(i));
      } else {
        numb.add(double.parse(res.elementAt(i)));
      }
    }
    res.clear();
    res = removeSign(numb, sin, '/');
    // print('thsi is');
    // print(res);
    return res;
  }

// this method calculate f(x)
  double calculate_Y(Queue Function) {
    double firstTerm = 0.0, secondTerm = 0.0;
    Queue numb = new Queue();
    for (int i = 0; i < Function.length; i += 2)
      numb.add(double.parse(Function.elementAt(i)));

    for (int i = 1; i < Function.length; i += 2) {
      if (Function.elementAt(i) == '+') {
        firstTerm = numb.removeFirst();
        secondTerm = numb.removeFirst();
        numb.addFirst(firstTerm + secondTerm);
      } else if (Function.elementAt(i) == '-') {
        firstTerm = numb.removeFirst();
        secondTerm = numb.removeFirst();
        numb.addFirst(firstTerm - secondTerm);
      }
    }
    double res = numb.removeFirst();
    return res;
  }

// this method returns the points that will be plot
  List<Point> getPoints(String function, int minX, int max_X) {
    List<Point> res = [];
    Queue fun = new Queue();
    Queue temp1 = new Queue();
    Queue temp2 = new Queue();
    String s = '';

    for (int i = 0; i < function.length; i++) {
      if (function[i] != '+' &&
          function[i] != '-' &&
          function[i] != '/' &&
          function[i] != '^' &&
          function[i] != '*')
        s += function[i];
      else {
        fun.add(s);
        fun.add(function[i]);
        s = '';
      }
    }
    fun.add(function[function.length - 1]);

    for (int i = minX; i <= max_X; i++) {
      temp1 = remove_X(i, fun);
      temp2 = simplifiedFun(temp1);
      double fx = calculate_Y(temp2);
      Point temp = new Point(i, fx);
      res.add(temp);
      temp1.clear();
      temp2.clear();
    }
    print(res);

    return res;
  }

// this method reomve the '^' , '*' and '/' to make the function more simple
  Queue removeSign(Queue numbers, Queue signs, String singToRemove) {
    Queue res = new Queue();
    while (signs.isEmpty != true) {
      if (signs.first == singToRemove) {
        double frtTerm = numbers.removeFirst();
        double secTerm = numbers.removeFirst();
        if (singToRemove == '^' && signs.first == '^') {
          numbers.addFirst(pow(frtTerm, secTerm));
        } else if (singToRemove == '*' && signs.first == '*') {
          numbers.addFirst(frtTerm * secTerm);
        } else if (singToRemove == '/' && signs.first == '/') {
          if (secTerm == 0) {
            numbers.addFirst(0.0);
            break;
          } else
            numbers.addFirst(frtTerm / secTerm);
        }
        signs.removeFirst();
      } else {
        res.add(numbers.removeFirst().toString());
        res.add(signs.removeFirst().toString());
      }
    }
    res.add(numbers.first.toString());
    return res;
  }
}
