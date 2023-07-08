// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class UserProfileScreen extends StatelessWidget {
//   const UserProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
//         child: Obx(
//           () => ListView(
//             children: [
//               const SizedBox(height: 20),
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 250,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.grey[100],
//                       border: Border.all(
//                         color: const Color.fromARGB(255, 232, 231, 231),
//                       ),
//                       image: profC.imageUri.value == "" &&
//                                   profC.upImage.value?.path == null ||
//                               profC.upImage.value?.path == ""
//                           ? const DecorationImage(
//                               image: AssetImage(
//                                 "assets/images/ppicon.jpg",
//                               ),
//                               fit: BoxFit.contain,
//                             )
//                           : profC.upImage.value?.path != null
//                               ? DecorationImage(
//                                   image: FileImage(
//                                     File("${profC.upImage.value?.path}"),
//                                   ),
//                                 )
//                               : DecorationImage(
//                                   image: NetworkImage(
//                                     profC.imageUri.value,
//                                   ),
//                                   fit: BoxFit.contain,
//                                 ),
//                     ),
//                   ),
//                   Container(
//                     width: Get.width * 0.9,
//                     height: 35,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(5),
//                         bottomRight: Radius.circular(5),
//                       ),
//                       color: Colors.black.withOpacity(0.4),
//                     ),
//                     child: Row(
//                       children: [
//                         IconButton(
//                           onPressed: () async {
//                             // await profC.getImage(ImageSource.camera);
//                           },
//                           icon: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 22,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () async {
//                             // await profC.getImage(ImageSource.gallery);
//                           },
//                           icon: const Icon(
//                             Icons.open_in_browser,
//                             color: Colors.white,
//                             size: 22,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
