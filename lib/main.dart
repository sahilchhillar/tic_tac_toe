import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "TicTacToe",
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToe createState() => _TicTacToe();
}

class _TicTacToe extends State<TicTacToeGame> {
  bool playerX = true;
  List<String> choices = ['', '', '', '', '', '', '', '', ''];
  String player = 'X';
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            _clearBoard();
            playerX = true;
            player = 'X';
          },
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.replay,
            size: 50,
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "Tic-Tac-Toe",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.teal,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "It the turn of player $player",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                  controller: ScrollController(keepScrollOffset: false),
                  itemCount: choices.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (playerX) {
                          setState(() {
                            if (choices[index] == '') {
                              choices[index] = 'X';
                              playerX = false;
                              player = 'O';
                            }
                          });
                        } else {
                          setState(() {
                            if (choices[index] == '') {
                              choices[index] = 'O';
                              playerX = true;
                              player = 'X';
                            }
                          });
                        }

                        _checkWinner();
                      },
                      child: box(player, choices, index),
                    );
                  }),
            ),
          ],
        ));
  }

  Container box(String player, List<String> choices, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.all(8),
      color: Colors.teal[100],
      child: Center(
          child: Text(
        choices[index],
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      )),
    );
  }

  void _clearBoard() {
    setState(() {
      for (var i = 0; i < choices.length; i++) {
        choices[i] = '';
      }
    });
  }

  void _checkWinner() {
    // Checking rows
    if (choices[0] == choices[1] &&
        choices[0] == choices[2] &&
        choices[0] != '') {
      _showWinDialog(choices[0]);
    }
    if (choices[3] == choices[4] &&
        choices[3] == choices[5] &&
        choices[3] != '') {
      _showWinDialog(choices[3]);
    }
    if (choices[6] == choices[7] &&
        choices[6] == choices[8] &&
        choices[6] != '') {
      _showWinDialog(choices[6]);
    }

    // Checking Column
    if (choices[0] == choices[3] &&
        choices[0] == choices[6] &&
        choices[0] != '') {
      _showWinDialog(choices[0]);
    }
    if (choices[1] == choices[4] &&
        choices[1] == choices[7] &&
        choices[1] != '') {
      _showWinDialog(choices[1]);
    }
    if (choices[2] == choices[5] &&
        choices[2] == choices[8] &&
        choices[2] != '') {
      _showWinDialog(choices[2]);
    }

    // Checking Diagonal
    if (choices[0] == choices[4] &&
        choices[0] == choices[8] &&
        choices[0] != '') {
      _showWinDialog(choices[0]);
    }
    if (choices[2] == choices[4] &&
        choices[2] == choices[6] &&
        choices[2] != '') {
      _showWinDialog(choices[2]);
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" $winner \" is Winner!!!"),
            actions: [
              ElevatedButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                  setState(() {
                    playerX = true;
                    player = 'X';
                  });
                },
              )
            ],
          );
        });
  }
}
