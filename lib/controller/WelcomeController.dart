// ignore_for_file: file_names

import 'package:courseproject/Bottombar/bottombar.dart';
import 'package:courseproject/controller/HomeController.dart';
import 'package:courseproject/static/database.dart';
import 'package:courseproject/static/static.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class WelcomeController extends GetxController {
  String? mytoken;

  final myBox = Hive.box('mybox1');
  ToDoDataBase db = ToDoDataBase();

  final List<Map<String, dynamic>> slideContents = [
    {
      'imagePath': 'assets/images/img1.png',
      'text': 'مرحباَ بك',
      'showButton': false,
      'supText': '',
    },
    {
      'imagePath': 'assets/images/img1.png',
      'text': 'تعلم مع الأصدقاء',
      'showButton': false,
      'supText': 'ابحث عن أشخاص بالقرب منك تتشاركون الاهتمامات التعليمية نفسها',
    },
    {
      'imagePath': 'assets/images/img1.png',
      'text': '',
      'showButton': false,
      'supText': 'احصل على الدروس المناسبة لك وفقاَ لمستوى معرفتك',
    },
    {
      'imagePath': 'assets/images/img1.png',
      'text': '',
      'showButton': true,
      'supText':
          'اعتماداَ على مجموعة أسئلة تتعلق بخبراتك والمهارات التي ترغب بتعلمها',
    },
  ];

  int _currentPage = 0;
  final _pageController = PageController();

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    gettoken();
    if (myBox.get("NOT") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    getInit();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        notifications.add([
          message.notification!.title,
          message.notification!.body,
          getCurrentTime(),
        ]);
        db.updateDataBase();
        HomeController cont = Get.put(HomeController());
        cont.refresh();
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        FlutterRingtonePlayer.playNotification();
        Get.snackbar(
          message.notification!.title!,
          message.notification!.body!,
        );
        notifications.add([
          message.notification!.title,
          message.notification!.body,
          getCurrentTime(),
        ]);
        db.updateDataBase();
        HomeController cont = Get.put(HomeController());
        cont.refresh();
      }
    });
    super.onInit();
    _checkUserLoggedIn();
  }

  void _checkUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Get.put(HomeController());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(const MyHomePage());
      });
    }
  }

  void onPageChanged(int index) {
    _currentPage = index;
    update(); // لتحديث واجهة المستخدم
  }

  void goToNextPage() {
    if (_currentPage < slideContents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  getInit() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.notification != null) {
      notifications.add([
        initialMessage.notification!.title,
        initialMessage.notification!.body,
        getCurrentTime(),
      ]);
      db.updateDataBase();
    }
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh-mm a').format(now);
    return formattedTime;
  }

  gettoken() async {
    mytoken = await FirebaseMessaging.instance.getToken();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
