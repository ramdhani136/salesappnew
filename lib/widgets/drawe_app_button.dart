import 'package:flutter/material.dart';

class DrawerAppButton extends StatelessWidget {
  const DrawerAppButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Color.fromARGB(255, 121, 8, 14),
        ),
      );
    });
  }
}
