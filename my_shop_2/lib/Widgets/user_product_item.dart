import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/edit_product_screen.dart';
import '../Provider/products_provider.dart';


class UserProductItem extends StatelessWidget {
  final String? id;
  final String title;
  final String ImageUrl;

  UserProductItem({Key? key,
    required this.id,
  required this.title,
    required this.ImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessanger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProductScreen.screenName, arguments: id);
          }, icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,)),
          IconButton(onPressed: () async{
            try {
              await Provider.of<ProductsProvider>(context, listen: false).deleteProduct(id!);
              scaffoldMessanger.showSnackBar(SnackBar(content: Text('Succefully Deleted',textAlign: TextAlign.center,)));
            }catch (error){
              scaffoldMessanger.showSnackBar(
                SnackBar(content: Text('Deleting failed.',textAlign: TextAlign.center, ),
                )
              );
            }
          },
              icon: Icon(Icons.delete,
            color: Theme.of(context).errorColor ,))

        ],),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(ImageUrl),

      ),
    );
  }
}
