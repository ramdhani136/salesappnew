import 'package:flutter/material.dart';

class HomeMenuList extends StatelessWidget {
  final String title;
  bool primary = false;

  HomeMenuList({required this.title, bool? primary}) : super() {
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
              decoration: BoxDecoration(
                color: primary ? Colors.red[400] : Colors.grey[300],
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
