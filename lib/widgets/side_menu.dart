import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../screens/all_orders_screen.dart';
import '../screens/all_products_screen.dart';
import '../screens/main_screen.dart';
import '../services/utils.dart';
import 'drawer_listtile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<ThemeProvider>(context);
    final color = Utils(context).color;
    return  Drawer(
      backgroundColor:Theme.of(context).cardColor,
      child: ListView(

        children: [
          DrawerHeader(
              child: Image.asset('assets/images/buy-on-laptop.jpg'),

          ),
          DrawerListTile(
            titleText: 'Main',
            iconName: Icons.home_filled,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(),));
            },
          ),
          DrawerListTile(
            titleText: 'View all product',
            iconName: Icons.production_quantity_limits,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AllProductsScreen(),));
            },
          ),
          DrawerListTile(
            titleText: 'View all order',
            iconName: Icons.bookmark_border,
            onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AllOrdersScreen(),));
            },
          ),
          SwitchListTile(
            title:  Flexible(child: Text('Theme',style: Theme.of(context).textTheme.titleMedium,)),
            secondary: Icon(themeState.getDarkTheme?
             Icons.dark_mode:
            Icons.light,
              color: themeState.getDarkTheme? Colors.white:Colors.black,
            ),
            value: theme,
            onChanged: (value) {
              themeState.setDarkTheme = value;
            },
          )
        ],
      ),
    );
  }
}