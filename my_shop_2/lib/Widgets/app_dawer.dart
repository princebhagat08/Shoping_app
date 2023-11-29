import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_shop_2/Screens/cart_screen.dart';
import '../Screens/orders_screen.dart';
import '../Screens/user_product_screen.dart';
import '../Screens/product_overview_screen.dart';
import '../Provider/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello User'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.store_mall_directory_rounded),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductOverviewScreen.screenName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart_sharp),
            title: Text('My Cart'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CartScreen.screenName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('My Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.screenName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.screenName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('logout'),
            onTap: () {
             Navigator.of(context).pop();
             Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
