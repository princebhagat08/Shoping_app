import 'package:flutter/material.dart';
import 'package:my_shop_2/Screens/auth_screen.dart';
import 'package:my_shop_2/Screens/splash_screen.dart';
import '../Provider/orders_element.dart';
import '../Screens/cart_screen.dart';
import '../Screens/edit_product_screen.dart';
import '../Screens/orders_screen.dart';
import 'package:provider/provider.dart';

import './Screens/product_details_screen.dart';
import './Screens/product_overview_screen.dart';
import './Provider/products_provider.dart';
import 'Provider/auth.dart';
import 'Provider/cart.dart';
import './Screens/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
              create: (_) => ProductsProvider('', '' ,[]),
              update: (_, auth, previousProducts) =>

              ProductsProvider(
                  auth.token?? '',
                  auth.userId?? '',
                  previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, OrderList>(
            create: (_) => OrderList('','', []),
            update: (_, auth, previousOrders) => OrderList(
                auth.token?? '',
                auth.userId?? '',
                previousOrders == null ? [] : previousOrders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
                    .copyWith(secondary: Colors.redAccent)),
            home: auth.isAuth ? ProductOverviewScreen() : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder:(ctx, authResutlSnapshot)=>
                authResutlSnapshot.connectionState==ConnectionState.waiting ? SplashScreen():AuthScreen()),
            routes: {
              ProductOverviewScreen.screenName: (ctx) =>
                  ProductOverviewScreen(),
              ProductDetailsScreen.screenName: (ctx) => ProductDetailsScreen(),
              CartScreen.screenName: (ctx) => CartScreen(),
              OrdersScreen.screenName: (ctx) => OrdersScreen(),
              UserProductScreen.screenName: (ctx) => UserProductScreen(),
              EditProductScreen.screenName: (ctx) => EditProductScreen(),
              AuthScreen.routeName: (ctx) => AuthScreen(),
            },
          ),
        ));
  }
}
