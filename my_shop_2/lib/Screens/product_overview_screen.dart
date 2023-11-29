import 'package:flutter/material.dart';
import 'package:my_shop_2/Provider/products_provider.dart';
import '../Screens/cart_screen.dart';
import '../Widgets/app_dawer.dart';
import 'package:provider/provider.dart';
import '../Provider/cart.dart';
import '../Widgets/products_grid.dart';
import '../Widgets/badge.dart';

enum filterOptions {
  Favourite,
  ShowAll,
}

class ProductOverviewScreen extends StatefulWidget {
  static const screenName = './productOverviewScreen';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourite = false;
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchAndSetProducts()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apni Dukan'), actions: [
        PopupMenuButton(
          onSelected: (filterOptions selectedValue) {
            setState(
              () {
                if (selectedValue == filterOptions.Favourite) {
                  _showOnlyFavourite = true;
                } else {
                  _showOnlyFavourite = false;
                }
              },
            );
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            const PopupMenuItem(
              child: Text('Favourite'),
              value: filterOptions.Favourite,
            ),
            const PopupMenuItem(
              child: Text('Show All'),
              value: filterOptions.ShowAll,
            ),
          ],
        ),
        Consumer<Cart>(
          builder: (_, cart, child) => Baadge(
            value: cart.itemCount.toString(),
            color: Theme.of(context).colorScheme.secondary,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.screenName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        )
      ]),
      drawer: AppDrawer(),
      body:_isLoading?
      Center(child: CircularProgressIndicator(),):
       ProductsGrid(_showOnlyFavourite),
    );
  }
}
