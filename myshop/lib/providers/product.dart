import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    @required this.description,
    this.isFavorite = false,
  });

  void _saveFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void favoriteToggle(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://myshop-be641-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken');
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));

      if (response.statusCode >= 400) {
        _saveFavValue(oldStatus);
      }
    } catch (error) {
      _saveFavValue(oldStatus);
    }
  }
}
