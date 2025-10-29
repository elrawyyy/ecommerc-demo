import 'package:flutter/material.dart';

class CartManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(String title, String image) {
    final index = _cartItems.indexWhere((i) => i['title'] == title);
    if (index != -1) {
      _cartItems[index]['quantity'] += 1;
    } else {
      _cartItems.add({'title': title, 'image': image, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  int get totalItems =>
      _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
}
