import 'package:flutter/material.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';

class UserSetting extends StatelessWidget {
  const UserSetting({super.key});

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
            BackButtonCustom(onBack: () {}),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_pin, size: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    " Profile Setting",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 121, 8, 14),
                  ),
                ),
                // Visibility(
                //   visible: state.workflow.isNotEmpty,
                //   child: PopupMenuButton(
                //     padding: const EdgeInsets.all(0),
                //     icon: const Icon(
                //       Icons.more_vert,
                //       color: Color.fromARGB(255, 121, 8, 14),
                //     ),
                //     itemBuilder: (context) {
                //       return state.workflow.map((item) {
                //         return PopupMenuItem(
                //           child: InkWell(
                //             onTap: () async {
                //               Get.back();
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 10, vertical: 10),
                //               child: Text(item.action),
                //             ),
                //           ),
                //         );
                //       }).toList();
                //     },
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
