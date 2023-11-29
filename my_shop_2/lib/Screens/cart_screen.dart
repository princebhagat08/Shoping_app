import 'package:flutter/material.dart';
import '../Provider/cart.dart';
import '../Screens/orders_screen.dart';
import '../Widgets/cart_items.dart';
import 'package:provider/provider.dart';
import '../Provider/orders_element.dart';

class CartScreen extends StatelessWidget {
  static const screenName = './cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            // margin: EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(label: Text('₹${cart.totalAmount.toStringAsFixed(2)}')),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItems(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
              itemCount: cart.items.length,
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed:(widget.cart.totalAmount <=0|| _isLoading) ? null : () async {
          setState(() {
            _isLoading = true;
          });
         await Provider.of<OrderList>(context, listen: false).addOrder(widget.cart.items.values.toList(),
              widget.cart.totalAmount,
         );
         setState(() {
           _isLoading = false;
         });
          widget.cart.clear();
          Navigator.of(context).pushReplacementNamed(OrdersScreen.screenName);
        },
        child:_isLoading? CircularProgressIndicator(): Text('Order Now'));
  }
}
