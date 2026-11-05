import 'package:flutter/material.dart';

void main() {
  runApp(const MyCalApp());
}

const Color blk = Color(0xFF030407);
const Color cardbg = Color(0xFF0A0910);
const Color neonpurple = Color(0xFF9B35FF);
const Color purple = Color(0xFF7900FF);

class MyCalApp extends StatelessWidget {
  const MyCalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: blk,
        colorScheme: const ColorScheme.dark(primary: purple, secondary: cardbg),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputValue = "";
  String calculatedValue = "";
  String operator = "";
  @override
  Widget build(BuildContext context) {
    
      return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Calculator',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              inputValue.isEmpty ? "0" : inputValue,
              style: const TextStyle(fontSize: 60, color: Colors.white),
            ),
          ),
          ),
          Column( 
            children: [
              Row(
                children: [
                  Cbutton("C", Colors.white30, 29, 10, 5, 5, Colors.red, null), 
                  Cbutton("", Colors.white30, 10, 10, 5, 5, Colors.red, Icons.backspace_outlined),
                  Cbutton("%", Colors.white30, 10, 10, 5, 5, Colors.white, null),                  
                  Cbutton("/", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                ],
              ),
              Row(
                children: [
                  Cbutton("7", Colors.white30, 29, 10, 5, 5, Colors.white, null), 
                  Cbutton("8", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                  Cbutton("9", Colors.white30, 10, 10, 5, 5, Colors.white, null),                  
                  Cbutton("x", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                ],
              ),
              Row(
                children: [
                  Cbutton("4", Colors.white30, 29, 10, 5, 5, Colors.white, null), 
                  Cbutton("5", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                  Cbutton("6", Colors.white30, 10, 10, 5, 5, Colors.white, null),                  
                  Cbutton("-", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                ],
              ),
              Row(
                children: [
                  Cbutton("1", Colors.white30, 29, 10, 5, 5, Colors.white, null), 
                  Cbutton("2", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                  Cbutton("3", Colors.white30, 10, 10, 5, 5, Colors.white, null),                  
                  Cbutton("+", Colors.white30, 10, 10, 5, 5, Colors.white, null),
                ],
              ),
              Row(
                children: [
                  Cbutton("%", Colors.white30, 29, 10, 5, 100, Colors.white, null), 
                  Cbutton("0", Colors.white30, 10, 10, 5, 100, Colors.white, null),
                  Cbutton(".", Colors.white30, 10, 10, 5, 100, Colors.white, null),                  
                  Cbutton("=", Color.fromARGB(255, 255, 140, 0), 10, 10, 5, 100, Colors.white, null),
                ],
              ),
            ],
          ), 
        ],
      ),
    );
    
  }

Widget Cbutton(
  String text, 
  Color bgcolor, 
  double l, // Changed from int to double for EdgeInsets
  double r, 
  double t, 
  double b, 
  Color tcolor, 
  IconData? bicon, // Made nullable and changed to IconData?
) {
  return InkWell(
    onTap: () {
      if (text == "C") {
        setState(() {
          inputValue = "";
        });
      } else if(text =="+" || text== "-" || text== "/" || text == "x" || text == "%"){
        setState((){
          calculatedValue = inputValue;
          operator = text;
          inputValue = "";
          });
      } else if (text == "=") {
        setState(() {
          double num1 = double.parse(calculatedValue);
          double num2 = double.parse(inputValue);
          double result =0;
          switch(operator){
            case "+":
               result = num1 + num2;
               break;
            case "-":
               result = num1 - num2;
               break;
            case "/":
               result = num1 /  num2;
               break;
            case "x":
                result = num1 * num2;
                break;
            case "%":
                result = num1 % num2;
                break;
          }
          inputValue = result.toString();
          operator = "";
        });
      } else if (bicon == Icons.backspace_outlined) {
        setState(() {
          if (inputValue.isNotEmpty) {
            inputValue = inputValue.substring(0, inputValue.length - 1);
          }
        });
      } else {
      setState(() {
        inputValue = inputValue + text;
      });
      }
    },
  
    
    child: Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(100),
      ),
      margin: EdgeInsets.only(left: l, right: r, top: t, bottom: b),
      height: MediaQuery.of(context).size.width / 5.8,
      width: MediaQuery.of(context).size.width / 5.8,
      alignment: Alignment.center,
      child: bicon != null
          ? Icon(bicon, color: tcolor, size: 30) // Directly use IconData here
          : Text(
              text,
              style: TextStyle(color: tcolor, fontSize: 30),
            ),
    ),
  );
}
}