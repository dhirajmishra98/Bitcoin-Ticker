import 'dart:convert';
import 'package:http/http.dart' as http;

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

const apiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '9D2D4202-E416-474A-BA0D-E58094A52D42';

class CoinData {

  Future getCoinData (cryptoCurrency,selectedCurrency) async{
    String requestUrl = '$apiUrl/$cryptoCurrency/$selectedCurrency?apikey=$apiKey';

    http.Response response = await http.get(Uri.parse(requestUrl));
    if(response.statusCode == 200){
      var getData = jsonDecode(response.body);
      var lastPrice = getData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw Exception('Cannot Load Data !');
    }
  }

}
