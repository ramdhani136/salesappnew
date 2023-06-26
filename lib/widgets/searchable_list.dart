import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchableList extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  SearchableList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer",
          style: TextStyle(color: Colors.grey[700]),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () {
              showCustomModal(context);
            },
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {},
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 184, 183, 183),
                    width: 1,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: "Search your data",
                hintStyle: TextStyle(color: Colors.grey[300]),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              enabled: false,
            )),
      ],
    );
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
                      title: Text("PT. Jaya Abadi"),
                      subtitle: Text("Area 1"),
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
