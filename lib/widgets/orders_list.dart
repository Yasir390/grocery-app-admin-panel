
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../consts/consts.dart';
import 'orders_widget.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key,  this.isInDashboard=true});
final  bool isInDashboard ;
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return     StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').snapshots(),
      builder: ( context,  snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: SpinKitFadingCube(color: Colors.black,),
          );
        }
        else if(snapshot.hasError){
          return const Center(child: Text('Snapshot has error'));
        }
        else if(!snapshot.hasData){
          return const Center(child: Text('Snapshot has no data'));
        }
        else if(snapshot.hasData){
          return   Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length>5 && widget.isInDashboard? 5:snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return OrdersWidget(
                  price: snapshot.data!.docs[index]['price'],
                  totalPrice: snapshot.data!.docs[index]['totalPrice'],
                  productId: snapshot.data!.docs[index]['productId'],
                  userId: snapshot.data!.docs[index]['userId'],
                  imageUrl: snapshot.data!.docs[index]['imageUrl'],
                  userName: snapshot.data!.docs[index]['userName'],
                  quantity: snapshot.data!.docs[index]['quantity'],
                  orderDate: snapshot.data!.docs[index]['orderDate'],);
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 3,);
              },
            ),
          );;
        }
        else{
          return const Center(child: Text('Something wrong'));
        }

      },
    );











  }
}
