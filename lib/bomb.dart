// import 'package:flutter/material.dart';

// class MyBomb extends StatelessWidget {
// bool revealed;
// final function;

// MyBomb({required this.revealed, this.function});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: function,
//       child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Container(
//                       color: revealed ? Colors.red[800] : Colors.blue[400],
//                     ),
//                   ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  final bool revealed;
  final Function()? function;

  MyBomb({required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: revealed ? Colors.red[800] : Colors.blue[400],
          child: Center(
            child: revealed
                ? Icon(
                    Icons.bolt_outlined, // Replace with the appropriate bomb emoji
                    color: Color.fromARGB(255, 236, 232, 2),
                    size: 35.0,
                  )
                : null, // Hide the bomb emoji if not revealed
          ),
        ),
      ),
    );
  }
}

