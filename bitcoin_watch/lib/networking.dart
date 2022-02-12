import 'dart:convert';

import 'package:http/http.dart' as http;

// ?apikey=E8975F46-0CD8-494D-A055-61860C8AFBBB
// https://rest.coinapi.io/v1/exchangerate/BTC/USD?

String urlString = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
String apiKey = '?apikey=E8975F46-0CD8-494D-A055-61860C8AFBBB';

class Networker {
  String requestedCoin;
  Networker(this.requestedCoin);

  dynamic getResponse() async {
    
      var url = Uri.parse(urlString + requestedCoin + apiKey);

      var response = await http.get(url);

      var decodedData = jsonDecode(response.body);
      return decodedData;
    
  }
}
