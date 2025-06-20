class Crypto {
  final String name;
  final String symbol;
  final double price;
  final String imageUrl;

  Crypto({
    required this.name,
    required this.symbol,
    required this.price,
    required this.imageUrl,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'],
      symbol: json['symbol'].toUpperCase(),
      price: json['current_price'].toDouble(),
      imageUrl: json['image'],
    );
  }
}
