import 'package:flutter/material.dart';

class HomeMenuList extends StatelessWidget {
  final String title;
  bool primary = false;
  final IconData icon;

  HomeMenuList({
    required this.title,
    bool? primary,
    required this.icon,
  }) : super() {
    if (primary != null) {
      this.primary = primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("ke menu");
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 5,
          top: 5,
          right: 15,
          left: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              child: Icon(
                icon,
                color: primary ? Colors.white : Colors.red,
              ),
              decoration: BoxDecoration(
                color: primary ? Colors.red[400] : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
