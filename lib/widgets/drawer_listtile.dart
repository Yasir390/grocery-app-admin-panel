import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class DrawerListTile extends StatelessWidget {
  final String titleText;
  final IconData iconName;
  final VoidCallback onTap;


  const DrawerListTile({super.key, required this.titleText, required this.iconName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).getDarkTheme;
    return ListTile(
      onTap: onTap,
      title: Text(titleText,style: Theme.of(context).textTheme.titleMedium,),
      leading: Icon(iconName,color:theme? Colors.white:Colors.black),
    );
  }
}
