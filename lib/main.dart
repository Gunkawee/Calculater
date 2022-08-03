import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "0";
  String expression = "";

  buttonPress(String value) {
    setState(() {
      if (value == "CLEAR") {
        result = "0"; // ถ้ากด CLEAR ให้เป็น 0
      } else if (value == ".") {
        if (result.contains(".")) {
          return; // ถ้ามีจุดอยู่แล้ว ไม่ต้องทำอะไร
        } else {
          result = result + value; // ถ้าไม่มีจุดให้เพิ่มจุดลงไป
        }
      } else if (value == "=") {
        expression = result.replaceAll("x", "*"); //แปลงให้กดตัวคูณได้
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel(); //ช่วยเปลี่ยนผลลัพธ์เป็นตัวเลขจริง
        dynamic calculate = exp.evaluate(EvaluationType.REAL, cm);

        result = calculate.toString();
      } else {
        if (result == "0") {
          result = value; // ถ้าเป็น 0 แล้วกดตัวเลขจะเป็นตัวเลขที่กด
        } else {
          result = result +
              value; // ถ้าไม่ใช่ 0 แล้วกดตัวเลขจะเป็นตัวเลขที่กดกับตัวเลขที่มีอยู่แล้ว
        }
      }
    });
  }

  Widget myButton(String buttonLabel) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(24),
        onPressed: () => buttonPress(buttonLabel),
        child: Text(buttonLabel,
            style: TextStyle(
              fontSize: 20,
            )),
        shape: CircleBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculater'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  )),
              Expanded(child: Divider()),
              //ปุ่มกดหน้า UI
              Column(
                children: [
                  Row(
                    children: [
                      myButton("7"),
                      myButton("8"),
                      myButton("9"),
                      myButton("/"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  myButton("4"),
                  myButton("5"),
                  myButton("6"),
                  myButton("x"),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  myButton("1"),
                  myButton("2"),
                  myButton("3"),
                  myButton("-"),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  myButton("."),
                  myButton("0"),
                  myButton("00"),
                  myButton("+"),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  myButton("CLEAR"),
                  myButton("="),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
