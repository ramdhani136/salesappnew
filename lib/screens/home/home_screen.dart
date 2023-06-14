import 'package:flutter/material.dart';
import 'package:salesappnew/screens/home/widgets/menu_list.dart';
// import 'package:salesappnew/utils/location_gps.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  // LocationGps location = LocationGps();
  HomeScreen() : super() {
    // getLocation();
  }

  // Future<void> getLocation() async {
  //   await location.CheckLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.apps_outlined),
        backgroundColor: Color(0xFFE6212A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      "Semangat Pagi",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "Ryan Hadi Dermawan",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red[300],
                  radius: 20,
                  child: SvgPicture.asset(
                    'assets/icons/notif.svg',
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                ),
              ],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        child: ListView(
          children: [
            const Text(
              "Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HomeMenuList(
                    title: "Kunjungan",
                    primary: true,
                    icon: Icons.run_circle_sharp,
                  ),
                  HomeMenuList(
                    title: "Panggilan",
                    icon: Icons.phone,
                  ),
                  HomeMenuList(
                    title: "Tagihan",
                    icon: Icons.price_change_sharp,
                  ),
                  HomeMenuList(
                    title: "Pesanan",
                    icon: Icons.bus_alert_sharp,
                  ),
                  HomeMenuList(
                    title: "Barang",
                    icon: Icons.gif_box_sharp,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Info Promo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "See More",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 35,
                    height: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/promo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Lokasi Sekitar anda",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.gps_fixed_sharp,
                  size: 16,
                  color: Colors.green[800],
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Gps tidak aktif',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        // onTap: (){},
        selectedItemColor: Color(0xFFE6212A),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
