import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = "";

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        display = "";
      } else if (value == "=") {
        try {
          String finalExpression =
              display.replaceAll("×", "*").replaceAll("÷", "/");

          display = _calculate(finalExpression);
        } catch (e) {
          display = "Error";
        }
      } else {
        display += value;
      }
    });
  }

  String _calculate(String expression) {
    List<String> tokens = [];
    String number = "";

    for (int i = 0; i < expression.length; i++) {
      String ch = expression[i];

      if ("+-*/".contains(ch)) {
        tokens.add(number);
        tokens.add(ch);
        number = "";
      } else {
        number += ch;
      }
    }
    tokens.add(number);

    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double nextNum = double.parse(tokens[i + 1]);

      if (op == "+") {
        result += nextNum;
      } else if (op == "-") {
        result -= nextNum;
      } else if (op == "*") {
        result *= nextNum;
      } else if (op == "/") {
        result /= nextNum;
      }
    }

    return result.toString();
  }

  Widget buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(fontSize: 22),
          ),
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 40, 40),
        title: const Text("Calculator",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white),),
        centerTitle: true,

      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
        child: Column(
          children: [
            // Display
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(40),
                child: Text(
                  display,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        
            // Buttons with Bottom Gap Added
            Padding(
              padding: const EdgeInsets.only(bottom: 25), // 👈 GAP ADDED HERE
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton("7"),
                      buildButton("8"),
                      buildButton("9"),
                      buildButton("÷"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("4"),
                      buildButton("5"),
                      buildButton("6"),
                      buildButton("×"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("1"),
                      buildButton("2"),
                      buildButton("3"),
                      buildButton("-"),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton("C"),
                      buildButton("0"),
                      buildButton("="),
                      buildButton("+"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}