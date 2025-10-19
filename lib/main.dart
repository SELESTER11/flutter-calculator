import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Calc()));

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String d = '0', f = '', o = ''; // d=display, f=first num, o=operator
  bool r = false;

  void tap(String b) {
    setState(() {
      if (b == 'C') {
        d = '0'; f = ''; o = ''; r = false;
      } else if (b == '=') {
        if (f != '' && o != '') {
          var n1 = double.tryParse(f);
          var n2 = double.tryParse(d);
          if (n1 != null && n2 != null) {
            var res = o == '+' ? n1 + n2 :
                     o == '-' ? n1 - n2 :
                     o == '*' ? n1 * n2 :
                     n2 == 0 ? null : n1 / n2;
            if (res == null) {
              d = 'Error'; f = ''; o = ''; r = true;
            } else {
              d = res == res.toInt() ? '${res.toInt()}' : '$res';
              f = d; o = ''; r = true;
            }
          }
        }
      } else if ('+-*/'.contains(b)) {
        if (f != '' && o != '' && !r) tap('=');
        f = d; o = b; r = true;
      } else if (b == '.') {
        if (r) { d = '0.'; r = false; }
        else if (!d.contains('.')) d += '.';
      } else {
        if (r || d == '0') { d = b; r = false; }
        else if (d.length < 12) d += b;
      }
    });
  }

  Widget btn(String t, [Color? c]) => Expanded(
    child: Padding(
      padding: EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () => tap(t),
        style: ElevatedButton.styleFrom(
          backgroundColor: c ?? Colors.grey[800],
          padding: EdgeInsets.all(20)),
        child: Text(t, style: TextStyle(fontSize: 18)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Column(children: [
      Expanded(child: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(20),
        child: Text(d, style: TextStyle(color: Colors.white, fontSize: 40)),
      )),
      Column(children: [
        Row(children: [btn('C', Colors.grey), btn('/', Colors.orange)]),
        Row(children: [btn('7'), btn('8'), btn('9'), btn('*', Colors.orange)]),
        Row(children: [btn('4'), btn('5'), btn('6'), btn('-', Colors.orange)]),
        Row(children: [btn('1'), btn('2'), btn('3'), btn('+', Colors.orange)]),
        Row(children: [btn('0'), btn('.'), btn('=', Colors.orange)]),
      ]),
    ]),
  );
}
