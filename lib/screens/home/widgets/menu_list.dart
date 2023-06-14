import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMenuList extends StatelessWidget {
  final String title;
  bool primary = false;
  final IconData icon;

  HomeMenuList({
    super.key,
    required this.title,
    bool? primary,
    required this.icon,
  }) {
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
                color: primary ? Colors.red : Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: primary ? Colors.white : Colors.red[500],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
