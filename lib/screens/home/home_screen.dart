// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salesappnew/bloc/auth/auth_bloc.dart';
import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/bloc/location/location_bloc.dart';
import 'package:salesappnew/bloc/memo/memo_bloc.dart';
import 'package:salesappnew/bloc/user/user_bloc.dart';
import 'package:salesappnew/bloc/visit/visit_bloc.dart';
import 'package:salesappnew/config/Config.dart';
import 'package:salesappnew/models/key_value_model.dart';
import 'package:salesappnew/screens/dn/dn_screen.dart';
import 'package:salesappnew/screens/home/widgets/menu_list.dart';
import 'package:salesappnew/screens/invoice/invoice_screen.dart';
import 'package:salesappnew/screens/item/item_screen.dart';
import 'package:salesappnew/screens/order/order_screen.dart';
import 'package:intl/intl.dart';
import 'package:salesappnew/screens/visit/widgets/visit_modal_insert.dart';
import 'package:salesappnew/widgets/drawer_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationBloc locationbloc = LocationBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    locationbloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MemoBloc memoBloc = MemoBloc();

    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 121, 8, 14),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        backgroundColor: const Color(0xFFE6212A),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Opacity(
                    opacity: 0.5,
                    child: Text(
                      "Semangat Pagi",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    bloc: UserBloc()..add(GetUserLogin()),
                    builder: (context, state) {
                      // print(state);

                      if (state is UserLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      if (state is UserLoginLoaded) {
                        return Text(
                          state.data.name!,
                          style: const TextStyle(fontSize: 15),
                        );
                      }

                      return Container();
                    },
                  )
                ],
              ),
            ),
            // Row(
            //   children: [
            //     CircleAvatar(
            //       backgroundColor: Colors.red[300],
            //       radius: 20,
            //       child: SvgPicture.asset(
            //         'assets/icons/notif.svg',
            //         width: 18,
            //         height: 18,
            //         color: Colors.white,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //   ],
            // )
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
                    const Icon(
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
                          // locationbloc.add(
                          //   GetRealtimeGps(
                          //     duration: const Duration(seconds: 60),
                          //   ),
                          // );
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
                      // Navigator.of(context).push(
                      //   MaterialPageRoute<VisitScreen>(
                      //     builder: (_) => const VisitScreen(),
                      //   ),
                      // );
                      Navigator.pushNamed(context, '/visit');
                    },
                    title: "Visit",
                    primary: true,
                    icon: Icons.run_circle_sharp,
                  ),
                  HomeMenuList(
                    RunFUnction: () {
                      Navigator.pushNamed(context, '/callsheet');
                      // Navigator.of(context).push(
                      //   MaterialPageRoute<CallsheetScreen>(
                      //     builder: (_) => BlocProvider.value(
                      //       value: BlocProvider.of<AuthBloc>(context),
                      //       child: const CallsheetScreen(),
                      //     ),
                      //   ),
                      // );
                    },
                    title: "Callsheet",
                    icon: Icons.phone,
                  ),
                  // HomeMenuList(
                  //   RunFUnction: () {},
                  //   title: "Memo",
                  //   icon: Icons.info,
                  // ),
                  HomeMenuList(
                    RunFUnction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<OrderScreen>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AuthBloc>(context),
                            child: const OrderScreen(),
                          ),
                        ),
                      );
                    },
                    title: "Order",
                    icon: Icons.bus_alert_sharp,
                  ),
                  HomeMenuList(
                    RunFUnction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<DnScreen>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AuthBloc>(context),
                            child: const DnScreen(),
                          ),
                        ),
                      );
                    },
                    title: "Delivery",
                    icon: Icons.fire_truck_rounded,
                  ),
                  HomeMenuList(
                    RunFUnction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<InvoiceScreen>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AuthBloc>(context),
                            child: const InvoiceScreen(),
                          ),
                        ),
                      );
                    },
                    title: "Invoice",
                    icon: Icons.price_change_sharp,
                  ),
                  HomeMenuList(
                    RunFUnction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<ItemScreen>(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AuthBloc>(context),
                            child: const ItemScreen(),
                          ),
                        ),
                      );
                    },
                    title: "Item",
                    icon: Icons.gif_box_sharp,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Memo",
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
                    memoBloc.add(
                      MemoGetAllData(
                        limit: 2,
                        filters: const [
                          ["display", "=", "dashboard"],
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            BlocBuilder<MemoBloc, MemoState>(
              bloc: memoBloc
                ..add(
                  MemoGetAllData(
                    limit: 2,
                    filters: const [
                      ["display", "=", "dashboard"],
                    ],
                  ),
                ),
              builder: (context, stateMemo) {
                if (stateMemo is MemoIsLoading) {
                  const Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }

                if (stateMemo is MemoIsFailure) {
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          stateMemo.error,
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }

                if (stateMemo is MemoIsLoaded) {
                  return Column(
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent &&
                              stateMemo.hasMore) {
                            stateMemo.pageLoading = true;
                            stateMemo.hasMore = false;
                            memoBloc.add(
                              MemoGetAllData(
                                getRefresh: false,
                                limit: 2,
                                filters: const [
                                  ["display", "=", "dashboard"],
                                ],
                              ),
                            );
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: stateMemo.data.map((e) {
                              return Container(
                                width: Get.width - 40,
                                height: (Get.width - 40) / 1.7,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  '${Config().baseUri}public/${e['img']}',
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Widget yang akan ditampilkan ketika terjadi kesalahan
                                    return Image.asset(
                                      'assets/images/noimage.jpg',
                                      fit: BoxFit.fitHeight,
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "No Data",
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<LocationBloc, LocationState>(
              bloc: locationbloc,
              builder: (context, state) {
                if (state is LocationLoading) {
                  return const Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 223, 223, 223),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is LocationLoaded) {
                  return LocationAroundYou(locationbloc: locationbloc);
                }

                return Container();
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   // onTap: (){},
      //   selectedItemColor: const Color(0xFFE6212A),
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}

class LocationAroundYou extends StatefulWidget {
  const LocationAroundYou({
    super.key,
    required this.locationbloc,
  });

  final LocationBloc locationbloc;

  @override
  State<LocationAroundYou> createState() => _LocationAroundYouState();
}

class _LocationAroundYouState extends State<LocationAroundYou> {
  final CustomerBloc customerBloc = CustomerBloc();

  @override
  void dispose() {
    customerBloc.close();
    widget.locationbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      bloc: customerBloc
        ..add(
          GetAllCustomer(
            nearby: Nearby(
                lat: widget.locationbloc.cordinate!.latitude,
                lng: widget.locationbloc.cordinate!.longitude),
          ),
        ),
      builder: (context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Location Around you (${state is CustomerIsLoaded ? "${state.data.length} Of ${state.total}" : "0"})",
                  style: const TextStyle(
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
                    widget.locationbloc.add(GetLocationGps());
                  },
                ),
              ],
            ),
            Visibility(
              visible: state is CustomerIsFailure,
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  state is CustomerIsFailure ? state.error : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: state is CustomerIsLoading,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: state is CustomerIsLoaded,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent &&
                          (state is CustomerIsLoaded)
                      ? (state).hasMore
                      : false) {
                    state.hasMore = false;
                    customerBloc.add(
                      GetAllCustomer(
                        nearby: Nearby(
                            lat: widget.locationbloc.cordinate!.latitude,
                            lng: widget.locationbloc.cordinate!.longitude),
                        refresh: false,
                      ),
                    );
                  }

                  return false;
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount:
                            state is CustomerIsLoaded ? state.data.length : 0,
                        itemBuilder: (context, index) {
                          if (state is CustomerIsLoaded) {
                            Config config = Config();
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.grey[300],
                                child: state.data[index]['img'] != null
                                    ? ClipOval(
                                        child: FadeInImage(
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          fadeInCurve: Curves.easeInExpo,
                                          fadeOutCurve: Curves.easeOutExpo,
                                          placeholder: const AssetImage(
                                              'assets/images/loading.gif'),
                                          image: NetworkImage(
                                              "${config.baseUri}public/customer/${state.data[index]['img']}"),
                                          imageErrorBuilder: (_, __, ___) {
                                            return Image.asset(
                                              'assets/icons/profile.png',
                                            );
                                          },
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: Colors.grey[100],
                                      ),
                              ),
                              title: Text(state.data[index]['name']),
                              subtitle: Text(
                                  state.data[index]['customerGroup']['name']),
                              trailing: Text(state.data[index]['distance'] !=
                                      null
                                  ? "${NumberFormat("#,##0.00").format(state.data[index]['distance'] / 1000)} Km"
                                  : ""),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => VisitModalInsert(
                                    bloc: VisitBloc(),
                                    customer: KeyValue(
                                      name: state.data[index]['name'],
                                      value: state.data[index]['_id'],
                                    ),
                                    group: KeyValue(
                                      name: state.data[index]['customerGroup']
                                          ['name'],
                                      value: state.data[index]['customerGroup']
                                          ['_id'],
                                    ),
                                    branch: KeyValue(
                                      name: state.data[index]['branch']['name'],
                                      value: state.data[index]['branch']['_id'],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                    Visibility(
                      visible: state is CustomerIsLoaded && state.IsloadingPage,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
