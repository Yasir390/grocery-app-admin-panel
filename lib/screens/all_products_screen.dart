import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/menu_controller.dart';
import '../services/utils.dart';
import '../widgets/grid_products.dart';
import '../widgets/header.dart';
import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuControllerProvider>().getGridScaffoldKey,
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
                            context.read<MenuControllerProvider>().controlProductMenu();
                          }, title: 'All Products',

                      ),
                      Responsive(
                        mobile: ProductGridWidget(
                          crossAxisCount: size.width<660? 2:4,
                          childAspectRatio:size.width<660 && size.width>350 ? 0.9:0.8,
                          isInMain: false,
                        ),
                        desktop: ProductGridWidget(
                          // crossAxisCount: size.width<650? 2:4, //because already 4
                          childAspectRatio:size.width<1400 ? 0.8 : 1.08,
                          isInMain: false,
                        ),
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
