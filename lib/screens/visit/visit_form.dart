import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salesappnew/widgets/drawe_app_button.dart';
import 'package:salesappnew/widgets/input_custom.dart';

class VisitForm extends StatelessWidget {
  const VisitForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE6212A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const DrawerAppButton(),
            const Row(
              children: [
                Icon(Icons.directions_run, size: 17),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "Visit List",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(children: [
              // IconSearch(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VisitForm();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.bubble_chart,
                  color: Color.fromARGB(255, 121, 8, 14),
                ),
              ),
            ])
          ],
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(MyTabBar.preferredSize.height),
        //   child: Container(
        //     height: 55,
        //     color: Colors.white,
        //     child: TabBar(
        //       indicatorColor: const Color(0xFFF9D934),
        //       tabs: myTabs,
        //     ),
        //   ),
        // ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.all(10),
        // color: Colors.red,
        child: InfiniteScrollSelectList(),
      ),
    );
  }
}
