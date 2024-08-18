import 'dart:developer';
import 'package:admin_grocery_app/screens/edit_prod_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.id});
 final  String id;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String title = '';
  String price = '';
  String productCat = '';
  String? imageUrl;
  double salePrice = 0.0;
  bool isOnSale = false;
  bool isPiece = false;

 bool isLoading = false;
  @override
  void initState() {
    getProductData();
    super.initState();
  }
  Future<void> getProductData()async{
    setState(() =>isLoading = true);

    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('products').doc(widget.id).get();

      if (productsDoc == null) {
        return;
      } else {
        setState(() {
          title = productsDoc.get('title');
          price = productsDoc.get('price');
          productCat = productsDoc.get('productCategory');
          imageUrl = productsDoc.get('imageUrl');
          salePrice = productsDoc.get('salePrice');
          isOnSale = productsDoc.get('isOnSale');
          isPiece = productsDoc.get('isPiece');
        });
      }
    }on FirebaseException catch(error){
      setState(() =>isLoading = false);
      GlobalMethods.showErrorDialog(context: context, content: error.message.toString());

    }catch(error){
      setState(() =>isLoading = false);
      GlobalMethods.showErrorDialog(context: context, content: error.toString());

    }finally{
      setState(() =>isLoading = false);
    }

  }

  @override
  Widget build(BuildContext context) {
    log('imageURL : $imageUrl');
    final color = Utils(context).color;
    final size = Utils(context).getScreenSize;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProductScreen(
                          id: widget.id,
                          title: title,
                          price: price,
                          salePrice: salePrice,
                          productCat: productCat,
                          isOnSale: isOnSale,
                         isPiece: isPiece,
                         imageUrl: imageUrl
                             ??  'https://i0.wp.com/www.khan.com.bd/wp-content/uploads/2021/01/Orange-1kg.jpg?fit=1200%2C1200&ssl=1',
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 3,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl
                              ??  'https://i0.wp.com/www.khan.com.bd/wp-content/uploads/2021/01/Orange-1kg.jpg?fit=1200%2C1200&ssl=1',
                          height:90,
                          width: 90,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SpinKitChasingDots(color: Colors.black,),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                    ),
                    const Spacer(),
                    PopupMenuButton(itemBuilder: (context) => [
                      PopupMenuItem(
                          onTap: () {
                          },
                          value: 1,
                          child: const Text('Edit')),
                      PopupMenuItem(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });

                            await FirebaseFirestore.instance.collection('products').doc(widget.id).delete().then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });

                            while(Navigator.canPop(context)){
                              Navigator.pop(context);
                            }
                          },
                          value: 1,
                          child: const Text('Delete',style: TextStyle(color: Colors.red),)),
                    ],)
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(isOnSale? '\$${salePrice.toStringAsFixed(2)}':price,
                    style: textTheme.titleMedium,),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: isOnSale,
                        child: Text('\$$price', style: textTheme.titleMedium!.copyWith(
                          decoration: TextDecoration.lineThrough
                        ),)
                    ),
                    const Spacer(),
                    Text(isPiece?'Piece':'1KG', style: textTheme.titleMedium,),

                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                 Text(title, style: textTheme.titleLarge,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
