
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _currentNumber = '';
  String _number = '';
  String _displayedCharacter = '';
  double _result = 0;
  String _operator = '';


  void calculate(String number1, String number2, String operator){
      if(number1.isEmpty || number2.isEmpty || operator.isEmpty){
        return;
      }
      double n1 = double.parse(number1);
      double n2 = double.parse(number2);
      double result = 0;
      switch(operator){
        case '+' :
          result = n1+n2;
          break;
        case '-' :
          result = n1-n2;
          break;
        case 'x' :
          result = n1*n2;
          break;
        case '÷' :
          if (n2 != 0) {
            result = n1 / n2;
          } else {
            setState(()=> _displayedCharacter = 'Cannot divide 0');
            return;
        }
        default: break;
      }
      setState((){
        _number = '';
        _result = result.toDouble();
        _currentNumber = _result.toString();
        _displayedCharacter = _result.toStringAsFixed(2);
      });
  }

  void getNumber(String number){
    setState(() {
      _currentNumber += number;
      _displayedCharacter = _currentNumber.toString();
    });
  }

  void getOperator(String operator){
    setState(() {
      if(operator == '.' &&!_currentNumber.contains('.')){
        _currentNumber += operator;
        _displayedCharacter = _currentNumber;
      }
      else if(operator == 'C'){
        _displayedCharacter = '';
        _currentNumber = '';
        _operator = '';
        _result = 0;
      }
      else if(operator == '%'){
        double number = double.parse(_currentNumber);
        _result = number/100;
        _currentNumber = _result.toStringAsFixed(2);
        _displayedCharacter = _result.toStringAsFixed(2);
      }else{
        _displayedCharacter = operator;
        _operator = operator;
        _number = _currentNumber;
        _currentNumber = '';
      }
    });
  }

  void delete(){
    setState(() {
      _currentNumber = _currentNumber.substring(0, _currentNumber.length -1);
      _displayedCharacter = _currentNumber;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Text(_displayedCharacter, style: const TextStyle(color: Colors.cyan, fontSize:50),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                operatorButtonWidget('C'),
                operatorButtonWidget('%'),
                deleteButton(),
                operatorButtonWidget('+')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                numberButtonWidget('1'),
                numberButtonWidget('8'),
                numberButtonWidget('9'),
                operatorButtonWidget('-')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                numberButtonWidget('4'),
                numberButtonWidget('5'),
                numberButtonWidget('6'),
                operatorButtonWidget('x')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                numberButtonWidget('1'),
                numberButtonWidget('2'),
                numberButtonWidget('3'),
                operatorButtonWidget('÷')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                saveButton(),
                numberButtonWidget('0'),
                operatorButtonWidget('.'),
                calculateButton()
              ],
            ),
          ],
              ),
    );
  }

  Widget numberButtonWidget(String numberText){
    return InkWell(
      onTap: ()=> getNumber(numberText),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1)
        ),
        child: Center(child: Text(numberText, style: const TextStyle(fontSize: 30))),
      ),
    );
  }


  Widget operatorButtonWidget(String operator){
    return InkWell(
      onTap: ()=>getOperator(operator),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1)
        ),
        child: Center(child: Text(operator, style: const TextStyle(fontSize: 30, color: Colors.cyan))),
      ),
    );
  }

  Widget deleteButton(){
    return InkWell(
      onTap: delete,
      child: Container(
        width: 80, height: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1)
        ),
        child: const Center(child: Icon(Icons.backspace_outlined, color: Colors.cyan, size: 30,),
      ),
    ));

}

  Widget calculateButton(){
    return InkWell(
        onTap: ()=>calculate( _number,_currentNumber, _operator),
        child: Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
              color: Colors.cyan,
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1)
          ),
          child: const Center(child: Text('=', style: TextStyle(fontSize: 30,color: Colors.white)),
          ),
        ));
  }

  Widget saveButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 80, height: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1)
        ),
        child: const Center(
            child: Icon(Icons.collections_bookmark_sharp, color: Colors.cyan,)),
      ),
    );
  }
}
