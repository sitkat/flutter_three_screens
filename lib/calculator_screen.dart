import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = '0';
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = '';

  void buttonPressed(String buttonText) {
    if (output == 'Infinity'){
      clear();
    }
    if (buttonText == 'C') {
      clear();
    } else if (isOperator(buttonText)) {
      handleOperator(buttonText);
    } else if (buttonText == '=') {
      calculateResult();
    } else {
      appendDigit(buttonText);
    }
  }

  bool isOperator(String text) {
    return ['+', '-', 'x', '/'].contains(text);
  }

  void clear() {
    setState(() {
      output = '0';
      num1 = 0.0;
      num2 = 0.0;
      operand = '';
    });
  }

  void handleOperator(String operator) {
    num1 = double.parse(output);
    operand = operator;
    setState(() {
      output = '0';
    });
  }

  void calculateResult() {
    num2 = double.parse(output);
    double result;
    switch (operand) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        result = (num2 != 0) ? (num1 / num2) : double.infinity;
        break;
      default:
        result = num2;
    }
    setState(() {
      output = result.toString();
    });
    num1 = result;
    operand = '';
  }

  void appendDigit(String digit) {
    if (output == '0') {
      setState(() {
        output = digit;
      });
    } else {
      setState(() {
        output += digit;
      });
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(24.0)),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Text(output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        const Expanded(
          child: Divider(),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('/'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('x'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('.'),
                buildButton('0'),
                buildButton('C'),
                buildButton('+'),
              ],
            ),
            Row(
              children: <Widget>[
                buildButton('='),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
