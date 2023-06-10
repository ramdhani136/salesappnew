import 'package:flutter/material.dart';

class LatihanScreen extends StatelessWidget {
  const LatihanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFE6212A),
          centerTitle: true,
          title: const Text("Flutter Bloc"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Initial Value",
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Decrement -",
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Icrement +",
                      style: TextStyle(fontSize: 23),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
