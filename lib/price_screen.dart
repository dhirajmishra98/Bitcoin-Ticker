import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  String bitCoinValue1 = '?';
  String bitCoinValue2 = '?';
  String bitCoinValue3 = '?';
  void getData () async{
    try{
      double data1 = await CoinData().getCoinData(cryptoList[0],selectedCurrency);
      double data2 = await CoinData().getCoinData(cryptoList[1],selectedCurrency);
      double data3 = await CoinData().getCoinData(cryptoList[2],selectedCurrency);
      setState(() {
        bitCoinValue1 = data1.toStringAsFixed(1);
        bitCoinValue2 = data2.toStringAsFixed(1);
        bitCoinValue3 = data3.toStringAsFixed(1);
      });
    } catch (e){
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              BitCoinBox(selectedBitcoin: cryptoList[0],bitCoinValue: bitCoinValue1, selectedCurrency: selectedCurrency),
              BitCoinBox(selectedBitcoin: cryptoList[1],bitCoinValue: bitCoinValue2, selectedCurrency: selectedCurrency),
              BitCoinBox(selectedBitcoin: cryptoList[2],bitCoinValue: bitCoinValue3, selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class BitCoinBox extends StatelessWidget {
  BitCoinBox({
    @required this.selectedBitcoin,
    @required this.bitCoinValue,
    @required this.selectedCurrency,
  });

  final String bitCoinValue;
  final String selectedCurrency;
  final String selectedBitcoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedBitcoin = $bitCoinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
