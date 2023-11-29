import 'dart:convert';

import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;

class OrderElement {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderElement({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class OrderList with ChangeNotifier {
  List<OrderElement> _orders = [];

  List<OrderElement> get orders {
    return [..._orders];
  }

  final String authToken;
  final String userId;
  OrderList(this.authToken,this.userId, this._orders);

  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://flutter-shoping-application-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderElement> loadedOrders = [];

    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }

    final Map<String, dynamic> orderData =
        extractedData as Map<String, dynamic>;

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderElement(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantitty']))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ),
      );
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url = Uri.parse(
        'https://flutter-shoping-application-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    var _dataTime = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': _dataTime.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantitty': cp.quantity,
                  })
              .toList(),
        }));

    _orders.insert(
      0,
      OrderElement(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProduct,
        dateTime: _dataTime,
      ),
    );
    notifyListeners();
  }
}
