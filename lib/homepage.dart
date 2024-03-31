import 'package:demolition_expert/bomb.dart';
import 'package:demolition_expert/numberbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int NumberOfSquares = 9 * 9;
  int NumberInEachRow = 9;

  var squareStatus = [];

  List<int> bombLocation = [
    80,
    1,
    10,
    35,
    45,
    55,
    70,
    62,
  ];

  bool bombsRevealed = false;
  int elapsedTimeInSeconds = 0; // Variable to store elapsed time
  late Timer timer; // Timer instance

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < NumberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    restartGame();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel(); // Cancel the timer when the widget is disposed
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        elapsedTimeInSeconds++;
      });
    });
  }



void restartGame() {
  setState(() {
    elapsedTimeInSeconds = 0; // Reset the elapsed time
    bombsRevealed = false;

    // Randomize bomb locations
    bombLocation.clear();
    final random = Random();
    while (bombLocation.length < 8) {
      final randomIndex = random.nextInt(NumberOfSquares);
      if (!bombLocation.contains(randomIndex)) {
        bombLocation.add(randomIndex);
      }
    }

    // Reset squareStatus
    for (int i = 0; i < NumberOfSquares; i++) {
      squareStatus[i][1] = false;
    }

    // Re-scan bomb positions
    scanBombs();
  });
}



  void revealBoxNumbers(int index) {
    if(squareStatus[index][0] != 0){
      setState(() {
        squareStatus[index][1] = true;
      });
    }
    else if (squareStatus[index][0] == 0){
      setState(() {
        squareStatus[index][1] = true;

      if(index % NumberInEachRow != 0){
        if(squareStatus[index - 1][0] == 0 && squareStatus[index - 1][1] == false) {
          revealBoxNumbers(index-1);
        }
        squareStatus[index-1][1] = true;
      }
      if(index % NumberInEachRow != 0 && index>=NumberInEachRow){
        if(squareStatus[index - 1-NumberInEachRow][0] == 0 && squareStatus[index - 1 - NumberInEachRow][1] == false) {
          revealBoxNumbers(index-1-NumberInEachRow);
        }
        squareStatus[index-1-NumberInEachRow][1] = true;
      }
      if(index >= NumberInEachRow ){
        if(squareStatus[index - NumberInEachRow][0] == 0 && squareStatus[index - NumberInEachRow][1] == false) {
          revealBoxNumbers(index-NumberInEachRow);
        }
        squareStatus[index-NumberInEachRow][1] = true;
      }
      if( index>= NumberInEachRow && index % NumberInEachRow != NumberInEachRow - 1){
        if(squareStatus[index + 1 - NumberInEachRow][0] == 0 && squareStatus[index + 1 - NumberInEachRow][1] == false) {
          revealBoxNumbers(index+1-NumberInEachRow);
        }
        squareStatus[index+1-NumberInEachRow][1] = true;
      }
      if(index % NumberInEachRow != NumberInEachRow - 1){
        if(squareStatus[index + 1][0] == 0 && squareStatus[index + 1][1] == false) {
          revealBoxNumbers(index + 1);
        }
        squareStatus[index + 1][1] = true;
      }
      if(index < NumberOfSquares - NumberInEachRow && index % NumberInEachRow != NumberInEachRow - 1){
        if(squareStatus[index + 1 + NumberInEachRow][0] == 0 && squareStatus[index + 1 + NumberInEachRow][1] == false) {
          revealBoxNumbers(index + 1 + NumberInEachRow);
        }
        squareStatus[index + 1 + NumberInEachRow][1] = true;
      }
      if(index < NumberOfSquares - NumberInEachRow){
        if(squareStatus[index + NumberInEachRow][0] == 0 && squareStatus[index + NumberInEachRow][1] == false) {
          revealBoxNumbers(index + NumberInEachRow);
        }
        squareStatus[index + NumberInEachRow][1] = true;
      }
      if(index < NumberOfSquares - NumberInEachRow && index % NumberInEachRow != 0){
        if(squareStatus[index - 1 + NumberInEachRow][0] == 0 && squareStatus[index - 1 + NumberInEachRow][1] == false) {
          revealBoxNumbers(index-1 + NumberInEachRow);
        }
        squareStatus[index-1 + NumberInEachRow][1] = true;
      }
      });
      
    }
  }


  void scanBombs() {
    for (int i = 0; i < NumberOfSquares; i++) {
      int numberOfBombArround = 0;

      if (bombLocation.contains(i - 1) && i % NumberInEachRow != 0) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i - 1 - NumberInEachRow) &&
          i % NumberInEachRow != 0 &&
          i >= NumberInEachRow) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i - NumberInEachRow) && i >= NumberInEachRow) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i + 1 - NumberInEachRow) &&
          i % NumberInEachRow != NumberInEachRow - 1 &&
          i >= NumberInEachRow) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i + 1) &&
          i % NumberInEachRow != NumberInEachRow - 1) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i + 1 + NumberInEachRow) &&
          i % NumberInEachRow != NumberInEachRow - 1 &&
          i < NumberOfSquares - NumberInEachRow) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i + NumberInEachRow) &&
          i < NumberOfSquares - NumberInEachRow) {
        numberOfBombArround++;
      }
      if (bombLocation.contains(i - 1 + NumberInEachRow) &&
          i < NumberOfSquares - NumberInEachRow &&
          i % NumberInEachRow != 0) {
        numberOfBombArround++;
      }
      setState(() {
        squareStatus[i][0] = numberOfBombArround;
      });
    }
  }

  void playerLost() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[700],
          title: Center(
            child: Text(
              'YOU LOST!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                restartGame();
                Navigator.pop(context);
              },
              child: Icon(Icons.refresh),
            )
          ],
        );
      },
    );
  }

  void playerWon() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[700],
          title: Center(
            child: Text(
              'YOU WON!',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                restartGame();
                Navigator.pop(context);
              },
              child: Icon(Icons.refresh),
            )
          ],
        );
      },
    );
  }

  void checkWinner() {
    int unrevealedBoxes = 0;
    for (int i = 0; i < NumberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }
    if (unrevealedBoxes == bombLocation.length) {
      playerWon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DEMOLITION EXPERT ⚡'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Color.fromARGB(228, 33, 149, 243),
      body: Column(children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade500,
                  blurRadius: 20,
                  offset: const Offset(3.0, 3.0),
                  spreadRadius: 1.0,
                ),
                const BoxShadow(
                  color: Color.fromARGB(255, 2, 50, 88),
                  blurRadius: 20,
                  offset: Offset(-4.0, -4.0),
                  spreadRadius: 15.0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    bombLocation.length.toString(),
                    style: TextStyle(fontSize: 40),
                  ),
                  Text('B O M B'),
                ],
              ),
              GestureDetector(
                onTap: restartGame,
                child: Card(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 40,
                  ),
                  color: Colors.blue[400],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(elapsedTimeInSeconds % 60).toString()}',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text('T I M E'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Expanded(
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: NumberOfSquares,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: NumberInEachRow),
              itemBuilder: (context, index) {
                if (bombLocation.contains(index)) {
                  return MyBomb(
                    revealed: bombsRevealed,
                    function: () {
                      setState(() {
                        bombsRevealed = true;
                      });
                      playerLost();
                    },
                  );
                } else {
                  return MyNumberBox(
                    child: squareStatus[index][0],
                    revealed: squareStatus[index][1],
                    function: () {
                      revealBoxNumbers(index);
                      checkWinner();
                    },
                  );
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Text(
            'C R E A T E D    B Y    V R A J',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ]),
    );
  }
}