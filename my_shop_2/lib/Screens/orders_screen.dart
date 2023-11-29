import 'package:flutter/material.dart';
import '../Provider/orders_element.dart';
import '../Widgets/app_dawer.dart';
import '../Widgets/single_order.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const screenName = './orderScreen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<OrderList>(context, listen: false).fetchAndSetOrder();

      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderlist = Provider.of<OrderList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderlist.orders.length,
              itemBuilder: (ctx, index) => SingleOrder(
                    order: orderlist.orders[index],
                  )),
    );
  }
}
