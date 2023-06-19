import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';
import 'package:salesappnew/screens/home/widgets/menu_list.dart';
// import 'package:salesappnew/utils/location_gps.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesappnew/screens/visit/checkin_screen.dart';
import 'package:salesappnew/screens/visit/visit_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationBloc locationbloc = LocationBloc();

  @override
  void dispose() {
    locationbloc.close(); // Menutup Bloc saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.apps_outlined),
        backgroundColor: const Color(0xFFE6212A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
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
                // CircleAvatar(
                //   backgroundColor: Colors.grey,
                //   radius: 20,
                //   backgroundImage: NetworkImage(
                //       'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
                // ),
              ],
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 248, 205, 76),
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gps_fixed_sharp,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      bloc: locationbloc,
                      builder: (context, state) {
                        if (state is LocationInitial) {
                          locationbloc.add(GetLocationGps());
                        }

                        if (state is LocationLoaded) {
                          locationbloc.add(
                            GetRealtimeGps(
                              duration: const Duration(minutes: 1),
                            ),
                          );
                          return Text(
                            locationbloc.address ?? "Gps Error!",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 75, 57, 3)),
                          );
                        }
                        if (state is LocationLoading) {
                          return const SizedBox(
                            width: 9,
                            height: 9,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 236, 181, 16)),
                            ),
                          );
                        }

                        if (state is LocationFailure) {
                          locationbloc.add(GetLocationGps(notLoading: true));
                          return Text(
                            state.error,
                            style: const TextStyle(fontSize: 13),
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Menu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HomeMenuList(
                    RunFUnction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return VisitScreen();
                        }),
                      );
                    },
                    title: "Visit",
                    primary: true,
                    icon: Icons.run_circle_sharp,
                  ),
                  HomeMenuList(
                    RunFUnction: () {},
                    title: "Callsheet",
                    icon: Icons.phone,
                  ),
                  HomeMenuList(
                    RunFUnction: () {},
                    title: "Information",
                    icon: Icons.info,
                  ),
                  HomeMenuList(
                    RunFUnction: () {},
                    title: "Invoice",
                    icon: Icons.price_change_sharp,
                  ),
                  HomeMenuList(
                    RunFUnction: () {},
                    title: "Order",
                    icon: Icons.bus_alert_sharp,
                  ),
                  HomeMenuList(
                    RunFUnction: () {},
                    title: "Item",
                    icon: Icons.gif_box_sharp,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Information",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "See More",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 320,
                    height: 320 / 1.7,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/promo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 320,
                    height: 320 / 1.7,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                      // image: const DecorationImage(
                      //   image: NetworkImage(
                      //       "https://sevima.com/wp-content/uploads/2022/07/WhatsApp-Image-2022-07-18-at-11.57.07-AM.jpeg"),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Location Around you",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 20,
                    color: Color.fromARGB(255, 114, 114, 114),
                  ),
                  onPressed: () {
                    locationbloc.add(GetLocationGps());
                  },
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[100],
                    ),
                    // backgroundImage: NetworkImage(
                    //     "https://www.eisai.co.id/id/image/GtkB01.jpg"),
                  ),
                  title: Text('PT. Karya Abadi Baru'),
                  subtitle: Text('Jabodetabek'),
                  trailing: Text("1.5 km"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const CheckInScreen();
                        },
                      ),
                    );
                    // Aksi yang dilakukan saat ListTile ditekan
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[100],
                    ),
                    // backgroundImage: NetworkImage(
                    //     "https://sgp1.digitaloceanspaces.com/radarbogor/2019/07/PT-Mayora.jpg"),
                  ),
                  title: Text('CV. Ekatunggal Timur'),
                  subtitle: Text('Area 1'),
                  trailing: Text("2 km"),
                  onTap: () {
                    // Aksi yang dilakukan saat ListTile ditekan
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[100],
                    ),
                    // backgroundImage: NetworkImage(
                    //     "https://assets.ayobandung.com/crop/0x72:960x615/750x500/webp/photo/2022/12/29/1689892557.jpg"),
                  ),
                  title: Text('PT. Jati Agung'),
                  subtitle: Text('Depok'),
                  trailing: Text("4 km"),
                  onTap: () {
                    // Aksi yang dilakukan saat ListTile ditekan
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        // onTap: (){},
        selectedItemColor: const Color(0xFFE6212A),
        items: const [
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
