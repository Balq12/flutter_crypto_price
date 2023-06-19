import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'network_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'coin_data.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getData();
    super.activate();
  }

  int coinNumber = 0;

  Future getData() async {
    List networkListData = [];
    for (String coin in cryptoList) {
      NetworkHelper networkHelper = NetworkHelper(coin: coin, currency: 'USD');
      var networkData = await networkHelper.getNetworkData();
      networkListData.add(networkData);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(networkListData: networkListData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.black,
          size: 100,
        ),
      ),
    );
  }
}
