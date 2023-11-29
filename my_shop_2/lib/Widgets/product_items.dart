

import 'package:flutter/material.dart';
import 'package:my_shop_2/Provider/auth.dart';
import '../Provider/product.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart';
import '../Screens/product_details_screen.dart';

class ProductItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context,listen: false);
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Center(
          child: Text(product.title),
        ),
        leading: Consumer<Product>(
          builder: (ctx, product, _) => IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(

                SnackBar(

                  content:product.isFavourite? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('Removed from favourite',textAlign: TextAlign.center, ),
                  )
                      :Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Added to favourite',textAlign: TextAlign.center, ),
                      ),
                  duration: Duration(seconds: 2),

                  behavior:SnackBarBehavior.floating ,
                  margin: EdgeInsets.only(bottom: 10,right: 5, left: 5),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ,
                ),
              );
              product.toggledFavourite(authData.token!, authData.userId!);
            },
            icon: Icon(
              product.isFavourite
                  ? Icons.favorite_outlined
                  : Icons.favorite_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            cart.addItem(product.id, product.price, product.title);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(

              SnackBar(

                content: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('Added to cart', ),
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(label: 'UNDO',
                  textColor: Colors.orangeAccent, onPressed: () {
                  cart.removeSingleItem(product.id);
                  },),
                behavior:SnackBarBehavior.floating ,
                margin: EdgeInsets.only(bottom: 10,right: 5, left: 5),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ,
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart),
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailsScreen.screenName,
            arguments: product.id,
          );
        },
        child: Hero(
          tag: product.id!,
          child: FadeInImage(
            placeholder: AssetImage('Assets/Images/product-placeholder.png'),
            image: NetworkImage(product.imageUrl),
           fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
