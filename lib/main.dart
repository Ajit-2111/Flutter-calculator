import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onClickButton(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser parser = Parser();
        Expression expression = parser.parse(userInput);
        ContextModel contextmodel = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, contextmodel);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    } else {
      input += value;
      hideInput = false;
      output = '';
      outputSize = 34.0;
    }
    // print(value);
    // print(input);
    // print(output);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(fontSize: outputSize, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
          ),
        ),
        Row(
          children: [
            button(
                text: 'AC', btnBgColor: operatorColor, textColor: orangeColor),
            button(
                text: '<', btnBgColor: operatorColor, textColor: orangeColor),
            button(
                text: '%', btnBgColor: operatorColor, textColor: orangeColor),
            button(text: '/', btnBgColor: operatorColor, textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: '7'),
            button(text: '8'),
            button(text: '9'),
            button(text: 'x', btnBgColor: operatorColor, textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: '4'),
            button(text: '5'),
            button(text: '6'),
            button(text: '-', btnBgColor: operatorColor, textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: '1'),
            button(text: '2'),
            button(text: '3'),
            button(text: '+', btnBgColor: operatorColor, textColor: orangeColor)
          ],
        ),
        Row(
          children: [
            button(text: '00'),
            button(text: '0'),
            button(text: '.'),
            button(text: '=', btnBgColor: operatorColor, textColor: orangeColor)
          ],
        ),
      ]),
    );
  }

  Widget button({text, textColor = Colors.white, btnBgColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(22),
              backgroundColor: btnBgColor),
          onPressed: () => onClickButton(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          )),
    ));
  }
}
