import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
final child;
bool revealed;
final function;

MyNumberBox({this.child, required this.revealed,  this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      color: revealed ? Colors.blue[300] : Colors.blue[400],
                      child: Center(
                      child: Text(
                     revealed ? (child == 0 ? ' ' : child.toString()) : ' ',
                     style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: child == 1 ? const Color.fromARGB(255, 37, 33, 243) : (child == 2 ? Color.fromARGB(255, 244, 1, 171) : Colors.red),
                     ),
                     )),
                    ),
                  ),
    );
    
  }
}

