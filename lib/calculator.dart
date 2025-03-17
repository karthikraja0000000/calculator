// import 'package:flutter/Cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'my_button.dart';

class Calculator extends StatefulWidget
{
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = "";
  var ans = "";

  final List<String> button = [
    'C',
    '',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  alignment: Alignment.centerRight,
                  // height: 10.h,
                  // width: 10.w,
                  child: Text(
                    userInput,
                    style: TextStyle(fontSize: 20.r, color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.r),
                  alignment: Alignment.centerRight,
                  // height: 10.h,
                  // width: 10.w,
                  child: Text(
                    ans,
                    style: TextStyle(
                      fontSize: 30.r,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemCount: button.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput = "";
                        ans = '0';
                      });
                    },
                    buttonText: button[index],
                    color: Colors.blue[50],
                    textColor: Colors.black,
                  );
                }
                // +/- button
                else if (index == 1) {
                  return MyButton(
                    buttonText: button[index],
                    color: Colors.blue[50],
                    textColor: Colors.red,
                  );
                }
                // % Button
                else if (index == 2) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput += button[index];
                      });
                    },
                    buttonText: button[index],
                    color: Colors.blue[50],
                    textColor: Colors.black,
                  );
                }
                // Delete Button
                else if (index == 3) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput = userInput.substring(
                          0,
                          userInput.length - 1,
                        );
                      });
                    },
                    buttonText: button[index],
                    color: Colors.blue[50],
                    textColor: Colors.green,
                  );
                }
                // Equal_to Button
                else if (index == 18) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: button[index],
                    color: Colors.orange[700],
                    textColor: Colors.white,
                  );
                }
                //  other buttons
                else {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput += button[index];
                      });
                    },
                    buttonText: button[index],
                    color:
                        isOperator(button[index])
                            ? Colors.blueAccent
                            : Colors.grey,
                    textColor:
                        isOperator(button[index]) ? Colors.white : Colors.black,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void equalPressed() {
    String finalUserInput = userInput;
    finalUserInput = userInput.replaceAll('x', '*');

    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    ans = eval.toString();
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
}
