// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'coinData.dart';
import 'networking.dart';

const kCoinTextStyle =
    TextStyle(color: Colors.lime, fontSize: 21, fontWeight: FontWeight.bold);

String selectedCurrency = 'USD';
String currentRate = '?';

void setUI(String rate, String selectedCur) {
  selectedCurrency = selectedCur;
  currentRate = rate;
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networker networkerC = Networker(selectedCurrency);

    getCoinRate(networkerC.getResponse());
  }

  void getCoinRate(dynamic data) async {
    var rate = await data;
    print(data);
    setState(() {
      String strRate = double.parse(rate['rate'].toString()).toStringAsFixed(2);
      setUI(strRate, selectedCurrency);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Watch'),
      ),
      //Main Column
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CoinCard(currentRate, selectedCurrency),
          Container(
            height: 65,
            margin: EdgeInsets.only(top: 200),
            child: Center(
              child: DropdownButton<String>(
                isExpanded: true,
                items: currenciesList.map((String x) {
                  return DropdownMenuItem(
                    value: x,
                    child: Center(child: Text(x)),
                  );
                }).toList(),
                value: selectedCurrency,
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrency = newValue.toString();
                    Networker networker = Networker(selectedCurrency);
                    getCoinRate(networker.getResponse());
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  String rate = '';
  String requestedCurrency = '';

  CoinCard(this.rate, this.requestedCurrency);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 10,
      color: Colors.grey,
      child: Center(
        child: Text(
          '1 BTC = $rate $requestedCurrency',
          style: kCoinTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
