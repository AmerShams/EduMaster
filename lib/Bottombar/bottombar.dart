// ignore_for_file: library_private_types_in_public_api

import 'package:courseproject/Admin/temp.dart';
import 'package:courseproject/controller/HomeController.dart';
import 'package:courseproject/static/static.dart';
import 'package:courseproject/static/utils.dart';
import 'package:courseproject/views/FavoritCours.dart';
import 'package:courseproject/views/FirstPage.dart';
import 'package:courseproject/views/NotificationPage.dart';
import 'package:courseproject/views/home_page.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FirstPage(),
    HomePage(),
    const FavoritCourse(),
    const TempView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth(2222), top: screenWidth(1000)),
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      Get.to(NotificationsPage());
                    },
                    highlightColor: Colors.lightBlue
                        .withOpacity(0.3), // لون التأثير عند الضغط
                    splashColor:
                        Colors.blue.withOpacity(0.4), // تأثير الحركة عند الضغط
                    child: Stack(
                      children: [
                        Container(),
                        Positioned(
                          child: IconButton(
                            onPressed: () {
                              Get.to(NotificationsPage());
                            },
                            icon: Container(
                              width: screenWidth(11),
                              height: screenWidth(11),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(133, 221, 241, 249),
                                border: Border.all(),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                FontAwesomeIcons.bell,
                                fill: 1,
                                size: screenWidth(15),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        if (notifications.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              child: Text(
                                '${notifications.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: screenWidth(30),
            ),
            GetBuilder<HomeController>(builder: (controller) {
              if (controller.user.value != null) {
                final email = controller.user.value!.email ?? '';
                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      email,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(173, 255, 0, 0),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
        actions: [
          Obx(() {
            if (controller.user.value != null) {
              return IconButton(
                onPressed: () async {
                  await controller.signOut();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(133, 221, 241, 249),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color.fromARGB(133, 221, 241, 249),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: screenWidth(3.5)),
          child: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
        child: Material(
          elevation: 33.0,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: GNav(
              hoverColor: const Color.fromARGB(159, 200, 200, 200),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(22),
                vertical: screenWidth(19),
              ),
              backgroundColor: const Color.fromARGB(255, 87, 125, 141),
              color: Colors.black,
              activeColor: Colors.white,
              tabActiveBorder: const Border.symmetric(
                vertical: BorderSide(
                    color: Colors.white, width: 0.4, style: BorderStyle.solid),
              ),
              gap: 7,
              iconSize: 18,
              textStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "PlayfairDisplay",
              ),
              tabBackgroundGradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 87, 125, 141),
                  Color.fromARGB(154, 203, 219, 226),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: FontAwesomeIcons.chalkboard,
                  text: "Courses",
                ),
                GButton(
                  icon: Icons.favorite,
                  text: "Favorit",
                ),
                GButton(
                  icon: Icons.admin_panel_settings,
                  text: "Admin",
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
