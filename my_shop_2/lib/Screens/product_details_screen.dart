import 'package:flutter/material.dart';
import '../Provider/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const screenName = './productDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,

            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title, style: TextStyle(color: Colors.white),),
              background: Hero(
                  tag: loadedProduct.id!,
                  child: FittedBox(fit:BoxFit.contain, child:Image.network(loadedProduct.imageUrl))),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Price:  ₹${loadedProduct.price}', textAlign: TextAlign.center,),
              ),
              SizedBox(
                height: 10,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(loadedProduct.title, textAlign: TextAlign.center),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Description:  ' + loadedProduct.description, textAlign: TextAlign.center),
              ),
              SizedBox(height: 800,)
            ]),
          ),
        ],
      ),
    );
  }
}
