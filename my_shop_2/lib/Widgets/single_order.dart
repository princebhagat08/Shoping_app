import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Provider/orders_element.dart';

class SingleOrder extends StatefulWidget {
  final OrderElement order;
  const SingleOrder({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<SingleOrder> createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(widget.order.products.length*20.0 +100, 200):95,
      child: Card(
          margin: EdgeInsets.all(10),
          child: Column(

            children: [
              ListTile(
                title: Text('₹${widget.order.amount}'),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy  hh:mm').format(widget.order.dateTime),
                ),
                trailing: IconButton(
                  icon:Icon(_expanded?Icons.expand_less :Icons.expand_more),
                  onPressed: (){
                    setState(() {
                      _expanded =! _expanded;
                    });
                  }, ),
              ),
                AnimatedContainer(
                 duration: Duration(milliseconds: 300),
                  height: _expanded ? min(widget.order.products.length*20.0 +8, 110):0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    // height: min(widget.order.products.length*20.0 +10, 100),
                    child: ListView.builder(itemCount:widget.order.products.length,
                        itemBuilder: (ctx, i)=> Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.order.products[i].title, style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('${widget.order.products[i].quantity}x₹${widget.order.products[i].price}')
                      ],
                    )),
                  ),
                )

            ],
          )),
    );
  }
}
