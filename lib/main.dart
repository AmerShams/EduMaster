// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:io';
import 'dart:ui';
import 'package:courseproject/controller/HomeController.dart';
import 'package:courseproject/controller/WelcomeController.dart';
import 'package:courseproject/static/database.dart';
import 'package:courseproject/static/static.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'views/welcome_page.dart';
import 'package:intl/intl.dart';

import 'package:hive_flutter/hive_flutter.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp();
  await Hive.initFlutter();
  FlutterRingtonePlayer.playNotification();

  var box = await Hive.openBox('mybox1');
  var toDoDatabase = ToDoDataBase();

  notifications = box.get('NOT', defaultValue: []);

  notifications.add([
    message.notification!.title,
    message.notification!.body,
    getCurrentTime(),
  ]);
  box.put('NOT', notifications);
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('hh-mm a').format(now);
  return formattedTime;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyDjOmmYSP8gZh4MZIJqt_EZK3JevE87KZ8",
          appId: "1:807549393328:android:2f9058fc235e2fbb271e75",
          messagingSenderId: "807549393328",
          projectId: "courses-5b9b1",
          storageBucket: "courses-5b9b1.appspot.com",
        ))
      : await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await Hive.openBox("mybox1");
  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Courses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Cairo',
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WelcomeController>(
        init: WelcomeController(),
        builder: (controller) {
          return Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.slideContents.length,
                        onPageChanged: controller.onPageChanged,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  controller.slideContents[index]['imagePath'],
                                  height: 200,
                                  width: 200,
                                ),
                                const SizedBox(height: 20),
                                if (controller.slideContents[index]
                                    ['showButton'])
                                  FractionallySizedBox(
                                    widthFactor: 0.7,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (index == 3) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const WelcomePage(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                      ),
                                      child: Text(
                                        index == 1
                                            ? 'أنشئ حسابك الشخصي'
                                            : 'هيا نبدأ',
                                      ),
                                    ),
                                  ),
                                Text(
                                  controller.slideContents[index]['text'],
                                  style: const TextStyle(
                                      fontSize: 24.0, color: Colors.white),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  alignment: Alignment.center,
                                  child: Text(
                                    controller.slideContents[index]['supText'],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        controller.slideContents.length,
                        (int index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage == index
                                  ? Colors.blueAccent
                                  : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.teal),
                            child: TextButton(
                              onPressed: controller.goToPreviousPage,
                              child: const Text(
                                'السابق',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal,
                            ),
                            child: TextButton(
                              onPressed: controller.goToNextPage,
                              child: const Text(
                                'التالي',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
