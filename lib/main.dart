import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
            'Sean',
            style: TextStyle(fontSize: 48),
            ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression.isEmpty ? '0' : _expression,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _result.isEmpty ? '0' : _result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('+'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              _buildButton('='),
              _buildButton('/'),
            ],
          ),
          Row(
            children: [
              _buildButton('C'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
      return Expanded(
        child: TextButton(
          onPressed: () {
            if (text == '=') {
              _calculateResult();
            } else if (text == 'C') {
              _clearExpression();
            } else {
              _addToExpression(text);
            }
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }
}