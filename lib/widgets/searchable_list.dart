import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchableList extends StatelessWidget {
  const SearchableList({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showCustomModal(context);
        },
        child: TextField(
          enabled: false,
        ));
  }

  void showCustomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Membuat modal menggunakan tinggi penuh
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: Get.width,
            padding:
                EdgeInsets.only(top: 40, left: 20, right: 20), // Lebar penuh
            height: MediaQuery.of(context).size.height, // Tinggi penuh
            child: Column(
              children: [
                TextField(),
                Expanded(child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("ddd"),
                    );
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
