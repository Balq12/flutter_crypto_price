import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getNewData(selectedCurrency, coin) async {
  NetworkHelper networkData =
      NetworkHelper(coin: coin, currency: selectedCurrency);
  dynamic newData = await networkData.getNetworkData();
  return newData;
}

String apiKey = '500A4FB6-CC40-41A6-BBA7-9E0A2402F338';

class NetworkHelper {
  String coin;
  String currency;
  late String url =
      'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=$apiKey';

  NetworkHelper({required this.coin, required this.currency});

  Future<dynamic> getNetworkData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rate'];
    } else {
      return null;
    }
  }
}
