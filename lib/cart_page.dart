import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_manager.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cart.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cart.cartItems.length,
        itemBuilder: (context, index) {
          final item = cart.cartItems[index];
          return Card(
            child: ListTile(
              leading: item['image'].toString().startsWith('http')
                  ? Image.network(item['image'],
                  width: 50, fit: BoxFit.cover)
                  : Image.asset(item['image'],
                  width: 50, fit: BoxFit.cover),
              title: Text(item['title']),
              subtitle: Text("Qty: ${item['quantity']}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => cart.removeItem(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
