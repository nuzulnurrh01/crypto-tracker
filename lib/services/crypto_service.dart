import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto.dart';

class CryptoService {
  static Future<List<Crypto>> fetchCryptos() async {
    final response = await http.get(
      Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load crypto data');
    }
  }
}
