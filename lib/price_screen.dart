import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'network_helper.dart';
import 'reusable_card.dart';

class PriceScreen extends StatefulWidget {
  PriceScreen({this.networkListData});

  dynamic networkListData;

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String selectedCurrency = 'USD';
  dynamic currencyValue1;
  dynamic currencyValue2;
  dynamic currencyValue3;
  String currency = 'USD';
  String coin = 'BTC';

  Widget getAndroidDropDownButton() {
    List<DropdownMenuItem<String>> newList = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> convertedItems = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
        value: currency,
      );
      newList.add(convertedItems);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (String? newValue) async {
        selectedCurrency = newValue.toString();
        List newDataList = [];
        for (String coin in cryptoList) {
          dynamic newData = await getNewData(selectedCurrency, coin);
          newDataList.add(newData);
        }
        updateUI(newDataList);
      },
      items: newList,
    );
  }

  Widget getIOSCupertinoPicker() {
    List<Widget> newlist = [];
    for (String currency in currenciesList) {
      Widget convertedItems = Center(
        child: Text(
          currency,
          style: TextStyle(color: Colors.white),
        ),
      );
      newlist.add(convertedItems);
    }
    return CupertinoPicker(
      magnification: 1.5,
      backgroundColor: Colors.lightBlue,
      itemExtent: 40,
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        List newDataList = [];
        for (String coin in cryptoList) {
          dynamic newData = await getNewData(selectedCurrency, coin);
          newDataList.add(newData);
        }
        updateUI(newDataList);
      },
      children: newlist,
    );
  }

  Future<void> updateUI(networkData) async {
    if (networkData == null) {
      currencyValue1 = 0;
      currencyValue2 = 0;
      currencyValue3 = 0;
      return;
    }
    setState(() {
      currencyValue1 = networkData[0].toStringAsFixed(2);
      currencyValue2 = networkData[1].toStringAsFixed(2);
      currencyValue3 = networkData[2].toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    updateUI(widget.networkListData);
    super.initState();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReusableCard(
                currencyValue: currencyValue1,
                selectedCurrency: selectedCurrency,
                indexNumber: 0,
              ),
              ReusableCard(
                currencyValue: currencyValue2,
                selectedCurrency: selectedCurrency,
                indexNumber: 1,
              ),
              ReusableCard(
                currencyValue: currencyValue3,
                selectedCurrency: selectedCurrency,
                indexNumber: 2,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? getIOSCupertinoPicker()
                : getAndroidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
