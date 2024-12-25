import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
        buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String input = '';
  String result = '';
  bool isCalculatorVisible = false;

  void onButtonPress(String buttonText) {
    setState(() {
      input += buttonText;
    });
  }

  void onEquals() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, cm);
      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }

  void onClear() {
    setState(() {
      input = '';
      result = '';
    });
  }

  void openCalculator() {
    setState(() {
      isCalculatorVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isCalculatorVisible)
              Column(
                children: [
                  Text(
                    'Welcome to the Calculator App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: openCalculator,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Open Calculator',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text(input, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(result, style: const TextStyle(fontSize: 24, color: Colors.blue)),
                  const SizedBox(height: 40),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      CalculatorButton(text: '7', onPress: () => onButtonPress('7')),
                      CalculatorButton(text: '8', onPress: () => onButtonPress('8')),
                      CalculatorButton(text: '9', onPress: () => onButtonPress('9')),
                      CalculatorButton(text: '÷', onPress: () => onButtonPress('÷')),
                      CalculatorButton(text: '4', onPress: () => onButtonPress('4')),
                      CalculatorButton(text: '5', onPress: () => onButtonPress('5')),
                      CalculatorButton(text: '6', onPress: () => onButtonPress('6')),
                      CalculatorButton(text: '×', onPress: () => onButtonPress('×')),
                      CalculatorButton(text: '1', onPress: () => onButtonPress('1')),
                      CalculatorButton(text: '2', onPress: () => onButtonPress('2')),
                      CalculatorButton(text: '3', onPress: () => onButtonPress('3')),
                      CalculatorButton(text: '-', onPress: () => onButtonPress('-')),
                      CalculatorButton(text: '0', onPress: () => onButtonPress('0')),
                      CalculatorButton(text: '.', onPress: () => onButtonPress('.')),
                      CalculatorButton(text: '=', onPress: onEquals),
                      CalculatorButton(text: '+', onPress: () => onButtonPress('+')),
                      CalculatorButton(text: 'C', onPress: onClear),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const CalculatorButton({required this.text, required this.onPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: Colors.blueAccent,
        elevation: 5,
      ),
    );
  }
}
