import 'package:http/http.dart' as http;
import 'dart:convert';


class CoinData{
  String selectedBitcoin;
  String Bitcoin;
  CoinData(this.Bitcoin,this.selectedBitcoin);

  Future<dynamic> getCoinData()async {
    http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$Bitcoin/$selectedBitcoin?apikey=AE334BD6-0B78-4028-B331-7691BAFD96AD#');
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      print(lastPrice);
      return lastPrice;
    }
    else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }


}



const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


