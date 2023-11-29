import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class Product with ChangeNotifier  {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;


  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
});


  Future<void> toggledFavourite(String token,String userId ) async{
    final oldValue = isFavourite;
    isFavourite =!isFavourite;
    notifyListeners();

    final url = Uri.parse(
        'https://flutter-shoping-application-default-rtdb.firebaseio.com/userFavourite/$userId/$id.json?auth=$token');
    try{
      final response = await http.put(url,
          body: json.encode(
         isFavourite,
      ) );
      if(response.statusCode>= 400){
        isFavourite = oldValue;
        notifyListeners();
      }
    } catch (error){
      isFavourite = oldValue;
      notifyListeners();
    }



  }
}