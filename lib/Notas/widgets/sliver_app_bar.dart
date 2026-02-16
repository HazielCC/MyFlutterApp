import 'package:agenda/Notas/pages/custom_search_delegate.dart';
import 'package:agenda/Notas/provider/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SliverAppBarr extends StatelessWidget {
  const SliverAppBarr({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SliverAppBar(
      expandedHeight: 70,
      floating: true,
      actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search)),
      ],
      title: Text(
        title,
        style: themeProvider.themeControl(28, FontWeight.normal),
      ),
    );
  }
}
