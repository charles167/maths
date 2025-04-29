import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "👋 Hi Charles!",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to Your Personal Calculator",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Calculator(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Open Calculator",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
      } else if (value == "+" || value == "-" || value == "×" || value == "÷") {
        _num1 = double.parse(_input);
        _operator = value;
        _input = "";
      } else if (value == "=") {
        _num2 = double.parse(_input);
        if (_operator == "+") _output = (_num1 + _num2).toString();
        if (_operator == "-") _output = (_num1 - _num2).toString();
        if (_operator == "×") _output = (_num1 * _num2).toString();
        if (_operator == "÷") _output = (_num1 / _num2).toString();
        _input = _output;
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  Widget _buildButton(String value, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: Colors.black45,
            elevation: 8,
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7", Colors.grey),
                  _buildButton("8", Colors.grey),
                  _buildButton("9", Colors.grey),
                  _buildButton("÷", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("4", Colors.grey),
                  _buildButton("5", Colors.grey),
                  _buildButton("6", Colors.grey),
                  _buildButton("×", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("1", Colors.grey),
                  _buildButton("2", Colors.grey),
                  _buildButton("3", Colors.grey),
                  _buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("C", Colors.red),
                  _buildButton("0", Colors.grey),
                  _buildButton("=", Colors.green),
                  _buildButton("+", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
