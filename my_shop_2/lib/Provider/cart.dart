import 'package:flutter/material.dart';

class CartItem{
  String id;
  String title;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
});
}


class Cart with ChangeNotifier{
  late Map<String, CartItem> _items={};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount{
    double totalPrice =0.0;
    _items.forEach((key, cartItem) {
      totalPrice += cartItem.price * cartItem.quantity;
    });
    return totalPrice;
  }

  int get itemCount {
    return _items.length;
   }

  void addItem(String? productId, double price, String title){
      if(_items.containsKey(productId)){
          _items.update(productId!, (existingProduct) => CartItem(
              id: existingProduct.id,
              title: existingProduct.title,
              price: existingProduct.price,
              quantity: existingProduct.quantity+1),
          );
      }else {
        _items.putIfAbsent(productId!, () => CartItem(
                        id: DateTime.now().toString(),
                         title: title,
                        price: price,
                        quantity: 1));
      }
      notifyListeners();
  }


  void removeSingleItem(String? productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(productId!, (existingItem) =>
          CartItem(id: existingItem.id, title: existingItem.title,
              price: existingItem.price, quantity: existingItem.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items ={};
    notifyListeners();
}

}