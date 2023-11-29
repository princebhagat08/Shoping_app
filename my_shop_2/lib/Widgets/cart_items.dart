import 'package:flutter/material.dart';
import '../Provider/cart.dart';
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItems(
    this.id,
     this.productId,
     this.price,
     this.quantity,
     this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,

      onDismissed: (direction) {


          Provider.of<Cart>(context, listen: false).removeItem(productId);


      },
      background: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: Theme.of(context).errorColor,
          child: Icon(Icons.delete, color: Colors.white,size: 30),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
        ),
      ),



      child: Card(
        elevation: 3,
        child:
        ListTile(
          leading: CircleAvatar(radius: 22,
            backgroundColor: Colors.teal,
            child: FittedBox(
                child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('₹${price}',style: TextStyle(color: Colors.black)),
              )),),
          title: Text(title),
          subtitle: Text('Total:${price*quantity}'),
          trailing: Text('${quantity}x'),
        ),
      ),
    );

  }
}
