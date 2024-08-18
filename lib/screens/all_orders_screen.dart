import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../controllers/menu_controller.dart';
import '../services/utils.dart';
import '../widgets/grid_products.dart';
import '../widgets/header.dart';
import '../widgets/orders_list.dart';
import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuControllerProvider>().getOrdersScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(Responsive.isDesktop(context))
                const Expanded(child: SideMenu()),
              Expanded(
                flex: 5,
                child:SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Header(
                        onTap:(){
                          context.read<MenuControllerProvider>().controlAllOrders();
                        }, title: 'All Orders',

                      ),
                      const SizedBox(
                        height: 20,
                      ),

                       const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: OrdersList(isInDashboard: false,),
                       )
                    ],
                  ),
                ) ,
              ),
            ],
          )
      ),
    );
  }
}
