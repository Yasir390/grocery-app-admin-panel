import 'package:admin_grocery_app/provider/theme_provider.dart';
import 'package:admin_grocery_app/screens/edit_prod_screen.dart';
import 'package:admin_grocery_app/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'controllers/menu_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyAiXTJLGgsyEYBzfdTIXLPz3KT5kk557EA",
  //       projectId: "grocery-app-project-new",
  //       messagingSenderId: "635309356149",
  //       appId: "1:635309356149:web:b6725652b2a1724724f43c"
  // ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.setDarkTheme =
        await themeProvider.themeSharedPrefs.getDarkTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return themeProvider;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => MenuControllerProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Admin Panel',
            debugShowCheckedModeBanner: false,
            theme: ThemeStyle.themeData(themeProvider.getDarkTheme, context),

            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
