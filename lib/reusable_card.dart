import 'package:flutter/material.dart';
import 'coin_data.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({
    Key? key,
    required this.indexNumber,
    required this.currencyValue,
    required this.selectedCurrency,
  }) : super(key: key);

  var currencyValue;
  final String selectedCurrency;
  int indexNumber;

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
            '1 ${cryptoList[indexNumber]} = ${currencyValue} $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
