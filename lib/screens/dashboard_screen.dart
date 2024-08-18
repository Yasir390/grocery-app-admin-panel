
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../controllers/menu_controller.dart';
import '../services/utils.dart';
import '../widgets/button_widget.dart';
import '../widgets/grid_products.dart';
import '../widgets/header.dart';
import '../widgets/orders_list.dart';
import '../widgets/product_widget.dart';
import '../widgets/responsive.dart';
import 'add_product_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

 @override
  Widget build(BuildContext context) {
   Size size = Utils(context).getScreenSize;
   final textTheme = Theme.of(context).textTheme;
    return SafeArea(
       child: SingleChildScrollView(
         controller: ScrollController(),
         padding: const EdgeInsets.all(8),
         child: Column(
           children: [
             Header(
               onTap:(){
                 context.read<MenuControllerProvider>().controlDashboardMenu();
               }, title: 'Dashboard',
             ),
             SizedBox(
               height: defaultPadding,
             ),
              Text('Latest Products',style: textTheme.titleLarge,),
             Row(
               children: [
                 ButtonWidget(
                   buttonText: 'View All',
                   iconName: Icons.store,
                   onPressed: () {},),
                 const Spacer(),
                 ButtonWidget(
                   buttonText: 'Add product',
                   iconName: Icons.add,
                   onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder:  (context) => const AddProductScreen(),));
                   },),
               ],
             ),
             const SizedBox(height: 10,),//defaultPadding
              Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                     flex: 5,
                     child: Column(
                   children: [
                        Responsive(
                          mobile: ProductGridWidget(
                            crossAxisCount: size.width<660? 2:4,
                            childAspectRatio:size.width<660 && size.width>350 ? 0.9:0.8,
                          ),
                          desktop: ProductGridWidget(
                            // crossAxisCount: size.width<650? 2:4, //because already 4
                            childAspectRatio:size.width<1400 ? 0.8 : 1.08,
                          ),
                        ),


                     OrdersList(),


                      ],
                 ))
               ],
             )
           ],
         ),
       ),
    );
  }
}
