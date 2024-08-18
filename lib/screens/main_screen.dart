import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/menu_controller.dart';
import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';
import 'dashboard_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuControllerProvider>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(Responsive.isDesktop(context))
                const Expanded(child: SideMenu()),
              const Expanded(flex: 5,
                child: DashboardScreen(),
              ),
            ],
          )
      ),
    );
  }
}