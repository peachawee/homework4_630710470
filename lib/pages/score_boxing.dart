import 'package:flutter/material.dart';

class BoxingPage extends StatefulWidget {
  const BoxingPage({Key? key}) : super(key: key);

  @override
  State<BoxingPage> createState() => _BoxingPageState();
}

class _BoxingPageState extends State<BoxingPage> {
  var R = 0;
  var redWin = false;
  var blueWin = false;
  var red = 0;
  var scoreRed = [];
  var blue = 0;
  var scoreBlue = [];

  Widget _buildTeam(
      String name,
      String team,
      String nation,
      int color,
      var Win
      ) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 72,
                  color: Color(
                    color,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 8.0),
                          child: Image.asset(
                            team,
                            width: 40,
                          ),
                        ),
                        Text(
                          nation,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(name),
                  ],
                )
              ],
            ),
          ),
          if (Win)
            Icon(
              Icons.check,
              color: Colors.green,
              size: 35,
            ),
        ],
      ),
    );
  }
//-------------------------------------------------------------------------------------------------------
  void _haddleClickedButton(int cl) {
    if (R < 3) {
      R++;
      if (cl == 0xFFA00000) {
        red += 10;
        blue += 9;
        scoreRed.add(10);
        scoreBlue.add(9);
      } else {
        red += 9;
        blue += 10;
        scoreRed.add(9);
        scoreBlue.add(10);
      }
      if (R >= 3) {
        if (red > blue)
          redWin = true;
        else
          blueWin = true;
      }
    } else {
      redWin = false;
      blueWin = false;
      red = 0;
      blue = 0;
      scoreRed = [];
      scoreBlue = [];
      R = 0;
    }
    setState(() {});
  }
//-------------------------------------------------------------------------------------------------------
  Widget _scoreBoard(String header, int red, int blue) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(header /*'ROUND ${r + 1}'*/),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              red.toString() /*redScore[r].toString()*/,
              style: TextStyle(fontSize: 30),
            ),
            Text(
              blue.toString() /*blueScore[r].toString()*/,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
        Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
//-------------------------------------------------------------------------------------------------------
  Widget _chooseWinnerButton(int cl) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(cl),
            padding: EdgeInsets.all(15),

          ),
          onPressed: () => _haddleClickedButton(cl),
          child: Icon(
            Icons.person,
            size: 30,
          ),
        ),
      ),
    );
  }
//-------------------------------------------------------------------------------------------------------
  Widget _resetButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.all(15),
          ),
          onPressed: () => _haddleClickedButton(0),
          child: Icon(
            Icons.clear,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
//-------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OLYMPIC BOXING SCORING'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          // fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        child: Column(
          children: [
//-------------------------------------------------------------------------------------------------------
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    Image.asset('assets/images/olympic.png', width: 100.0)),
                Text(
                  'TOKYO 2020',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.deepPurple[900],
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
//-------------------------------------------------------------------------------------------------------
            SizedBox(
              height: 5.0,
            ),
            Container(
              color: Colors.black,
              height: 23,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Women\'s Light(57-60kg) Semi-final',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
//-------------------------------------------------------------------------------------------------------
            _buildTeam('HARRINGTON Kellie Anne', 'assets/images/flag_ireland.png', 'IRELAND', 0xFFA00000, redWin),
//-------------------------------------------------------------------------------------------------------
            _buildTeam('SEESONDEE Sudaporn', 'assets/images/flag_thailand.png', 'THAILAND', 0xFF0000A0, blueWin),
//-------------------------------------------------------------------------------------------------------
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xFFA00000),
                    height: 5,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xFF0000A0),
                    height: 5,
                  ),
                ),
              ],
            ),
//-------------------------------------------------------------------------------------------------------
            SizedBox(
              height: 7,
            ),
            Expanded(
              child: Column(
                children: [
                  for (var r = 0; r < R; r++)
                    _scoreBoard('ROUND ${r + 1}', scoreRed[r], scoreBlue[r]),
                  if (R >= 3)
                    _scoreBoard('TOTAL', red, blue),
                ],
              ),
            ),
//-------------------------------------------------------------------------------------------------------
            Row(
              children: [
                if (R < 3) _chooseWinnerButton(0xFFA00000),
                if (R < 3) _chooseWinnerButton(0xFF0000A0),
                if (R >= 3) _resetButton(),
              ],
            )
//-------------------------------------------------------------------------------------------------------
          ],
        ),

      ),
    );
  }
}
