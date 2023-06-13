import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Semangat Pagi",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  "Ryan Hadi Dermawan",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Text("foto"),
          ],
        ),
        centerTitle: true,
      ),
      body: Text("Home"),
    );
  }
}
