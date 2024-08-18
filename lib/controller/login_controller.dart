import 'package:courseproject/controller/TempController.dart';
import 'package:courseproject/static/database.dart';
import 'package:courseproject/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LoginController extends GetxController {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box('mybox1');

  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formState = GlobalKey();

  login(context);
  // goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  TempController controller = Get.find();
  bool isLoading = false;
  void showCustomDialog2(
    BuildContext context,
    String title,
    String message,
  ) async {
    return Get.dialog(
      Dialog(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        message,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 22,
                        backgroundColor: const Color.fromARGB(169, 222, 15, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              maxWidth: double.infinity, minHeight: 50),
                          alignment: Alignment.center,
                          child: const Text(
                            "حسنا",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "cairo",
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  login(context) async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      update();
      if (email.text == "admin" && password.text == "admin") {
        isLoading = false;
        update();
        isAdmin = true;
        db.updateDataBase();
        controller.update();
      } else {
        isLoading = false;
        update();
        showCustomDialog2(
          context,
          'البريد الالكتروني او كلمة المرور غير صحيحة',
          '!!يرجى التأكد من البيانات المدخلة',
        );

        update();
      }
    }
  }

  @override
  void onInit() {
    if (_myBox.get("ISADMIN") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
