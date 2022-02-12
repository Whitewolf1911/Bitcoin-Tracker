import 'package:flutter/material.dart';
import 'mainPage.dart';

void main() {
  runApp(BitcoinWatch());
}

class BitcoinWatch extends StatelessWidget {
  const BitcoinWatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData.dark(),
      
    );
  }
}
