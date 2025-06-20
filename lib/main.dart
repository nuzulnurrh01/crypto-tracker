import 'package:flutter/material.dart';
import 'models/crypto.dart';
import 'services/crypto_service.dart';

void main() {
  runApp(CryptoApp());
}

class CryptoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Tracker',
      home: CryptoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CryptoListPage extends StatefulWidget {
  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late Future<List<Crypto>> cryptoList;

  @override
  void initState() {
    super.initState();
    cryptoList = CryptoService.fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crypto Tracker')),
      body: FutureBuilder<List<Crypto>>(
        future: cryptoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cryptos = snapshot.data!;
            return ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                return ListTile(
                  leading: Image.network(crypto.imageUrl, width: 40),
                  title: Text(crypto.name),
                  subtitle: Text(crypto.symbol),
                  trailing: Text('\$${crypto.price.toStringAsFixed(2)}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan 😢'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
