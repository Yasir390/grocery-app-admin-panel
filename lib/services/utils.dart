import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class Utils{
  BuildContext context;

  Utils(this.context);

  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get color => getTheme? Colors.white:Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}