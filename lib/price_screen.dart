import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform ;


class PriceScreen extends StatefulWidget {
  final coinRate;
  PriceScreen(this.coinRate);
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  String bitcoinValueInUSD;
  String bitCoin0,bitCoin1,bitCoin2;
  String Bitcoin;

  void fetch () async {
    for(int i=0;i<cryptoList.length;i++) {
      if (i == 0)
       { print(await  getData(cryptoList[i], selectedBitcoin));
        print(bitCoin0);}
      else if (i == 1)
        bitCoin1 = await getData(cryptoList[i], selectedBitcoin);
      else if (i == 2)
        bitCoin2 = await getData(cryptoList[i], selectedBitcoin);
    }
    print(bitCoin2);
    print(bitCoin1);
    print(bitCoin0);
  }


  Future<String> getData(String Bitcoin,String selectedBitcoin) async {
    try {
      double data = await CoinData(Bitcoin,selectedBitcoin).getCoinData();
      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
        return bitcoinValueInUSD;
      });
    } catch (e) {
      print(e);
    }
    return '';
  }

  void initState()  {
    super.initState();
    fetch();
  }


  String selectedBitcoin='USD';

  DropdownButton<String> getDropdownButton(){
    List<DropdownMenuItem<String>> dropdownitems=[];

    for(int i=0;i<currenciesList.length;i++){
      String currency = currenciesList[i];
      var newItem=DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedBitcoin,

      items: dropdownitems,
      onChanged: (value) {
        setState((){
          selectedBitcoin=value;
          fetch();
        });
      },
    );
  }

  CupertinoPicker iOSPicker(){

    List<Text> pickerItems =[];
    for(String currency in currenciesList){
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
      },
      children: pickerItems,
    );
  }

  Widget getPicker(){
    if(Platform.isIOS){
      return iOSPicker();
    }
    else
      return getDropdownButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $bitCoin0 $selectedBitcoin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $bitCoin1 $selectedBitcoin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $bitCoin2 $selectedBitcoin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
