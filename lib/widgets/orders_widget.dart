import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/utils.dart';

class OrdersWidget extends StatefulWidget {


   final double price,totalPrice;
   final String productId, userId,imageUrl,userName;
   final int quantity;
   final Timestamp orderDate;

  OrdersWidget({
    super.key,
    required this.price,
    required this.totalPrice,
    required this.productId,
    required this.userId,
    required this.imageUrl,
    required this.userName,
    required this.quantity,
    required this.orderDate,
  });

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
late String orderDateToShow;

  @override
  void initState() {
    var postDate = widget.orderDate.toDate();
    orderDateToShow = '${postDate.day}/${postDate.month}/${postDate.year}';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final textTheme = Theme.of(context).textTheme;
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex:size.width<660 ? 3 :1 ,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill,
                )
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${widget.quantity}X For \$${widget.price.toStringAsFixed(2)}',
                      style: textTheme.titleLarge,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          Text('By',style: textTheme.titleMedium!.copyWith(
                            color: Colors.blue
                          ),
                          ),
                          Text(widget.userName,style: textTheme.titleMedium,)
                        ],
                      ),
                    ),
                    Text(orderDateToShow,style: textTheme.titleMedium,)

                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}