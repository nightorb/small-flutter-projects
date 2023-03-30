import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MainApp());
}

// Um auf Variablen/Funktionen des child-Widgets zuzugreifen,
// müssen diese über einen GlobalKey übergeben werden:
// 1. GlobalKey erzeugen
// 2. Konstruktor des Child-Widgets ändern, um Key übergeben zu können
// 3. Key an Child-Widget übergeben bei der Konstruktion
// 4. über GlobalKey kann man auf den State zugreifen mit
//    (key).currentState.child_method

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // 1. Schritt:
  // GlobalKey setzen, um Funktionen des childs im parents aufrufen zu können
  final GlobalKey<_TicTacToeGridState> _myWidgetState =
    GlobalKey<_TicTacToeGridState>();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: Colors.deepPurple,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Tic Tac Toe'),
              centerTitle: true,

            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: TicTacToeGrid(key: _myWidgetState)
                  ), // 3. Schritt
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // resetGame(); // nicht aufrufbar
                _myWidgetState.currentState?.resetGame(); // 4. Schritt
              },
              child: const Icon(
                Icons.refresh
              ),
            ),
          ),
        );
      }
    );
  }
}

class TicTacToeGrid extends StatefulWidget {
  // 2. Schritt
  // Key über den Constructor des childs weitergeben
  const TicTacToeGrid({required Key key}) : super(key: key);

  @override
  State<TicTacToeGrid> createState() => _TicTacToeGridState();
}

class _TicTacToeGridState extends State<TicTacToeGrid> {
  
  // 9 leere Strings repräsentieren die 9 Tic Tac Toe Felder
  List<String> fields = ['', '', '', '', '', '', '', '', ''];

  int counter = 0;
  String message = '';

  void setIndex(int index) {
    setState(() {
      // mit Modulo checken, ob Counter gerade/ungerade ist
      // -> dadurch erreicht man, dass die Symbole abwechselnd erscheinen
      if (fields[index] == '') {
        if (counter % 2 == 0) {
          fields[index] = 'X';
        } else {
          fields[index] = 'O';
        }
        counter++;
      }
    });

    String winner = getWinner();

    if (winner != '') {
      setMessage('$winner hat gewonnen!');
    } else if (counter == 9) {
      setMessage('Spiel unentschieden');
    }
  }

  String getWinner() {
    // horizontale Reihen
    if (fields[0] == fields[1] && fields[0] == fields[2] && fields[0] != '') {
      return fields[0];
    }
    if (fields[3] == fields[4] && fields[3] == fields[5] && fields[3] != '') {
      return fields[3];
    }
    if (fields[6] == fields[7] && fields[6] == fields[8] && fields[6] != '') {
      return fields[6];
    }

    // verticale Reihen
    if (fields[0] == fields[3] && fields[0] == fields[6] && fields[0] != '') {
      return fields[0];
    }
    if (fields[1] == fields[4] && fields[1] == fields[7] && fields[1] != '') {
      return fields[1];
    }
    if (fields[2] == fields[5] && fields[2] == fields[8] && fields[2] != '') {
      return fields[2];
    }

    // diagonale Reihen
    if (fields[0] == fields[4] && fields[0] == fields[8] && fields[0] != '') {
      return fields[0];
    }
    if (fields[2] == fields[4] && fields[2] == fields[6] && fields[2] != '') {
      return fields[0];
    }

    return '';
  }

  void setMessage(String m) {
    setState(() {
      message = m;
    });
  }

  void resetGame() {
    setState(() {
      fields = ['', '', '', '', '', '', '', '', ''];
      counter = 0;
      message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          color: Colors.black87,
          child: GridView.builder(
            itemCount: 9,
            gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
              ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setIndex(index);
                },
                child: Container(
                  height: 80.w / 3,
                  width: 80.w / 3,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      width: (80.w / 3) - 20,
                      height: (80.w / 3) - 20,
                      decoration: BoxDecoration(
                        // gradient: const RadialGradient(
                        //   colors: [
                        //     Color.fromARGB(255, 237, 231, 246),
                        //     Color.fromARGB(255, 209, 196, 233)
                        //   ],
                        //   radius: 10,
                        // ),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          fields[index],
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.black87
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 20.0),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.black87
            ),
          ),
        ),
      ],
    );
  }
}
