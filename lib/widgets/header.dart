
import 'package:admin_grocery_app/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.onTap, required this.title,  this.showSearchBox = true});

  final String title;
  final VoidCallback onTap;
  final bool showSearchBox;

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = theme ? Colors.white : Colors.black;
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.menu),
          ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        if (Responsive.isDesktop(context))
          Spacer(
            flex: Responsive.isDesktop(context) ? 2 : 1,
          ),
        !showSearchBox? Container(): Expanded(
            child: TextField(
          decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Theme.of(context).cardColor.withOpacity(0.4),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              suffixIcon: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8 * 0.75),//defaultPadding
                  margin: const EdgeInsets.symmetric(horizontal: 8 / 2),//defaultPadding
                  decoration: BoxDecoration(
                     // color: theme?,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
          ),
        ),
        ),
      ],
    );
  }
}
