// ignore_for_file: unused_local_variable

import 'package:courseproject/controller/SignController.dart';
import 'package:courseproject/static/utils.dart';
import 'package:courseproject/static/valid.dart';
import 'package:courseproject/widgets/register/CustomRegister.dart';
import 'package:courseproject/widgets/register/CustomRegister1.dart';
import 'package:courseproject/widgets/register/CustomRegister2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignController controller = Get.put(SignController());

    return Scaffold(
      backgroundColor: Colors.grey,
      body: GetBuilder<SignController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'إنشاء حساب',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // اسم المستخدم
                CustomRegisterAuth(
                  hinttext: "اسم المستخدم",
                  iconData: Icons.verified_user_outlined,
                  isNumber: false,
                  mycontroller: controller.username,
                  valid: (val) {
                    return vaildInput(val, 2, 30);
                  },
                ),
                const SizedBox(height: 10),
                // البريد الالكتروني
                CustomRegisterAuth(
                  hinttext: "البريد الالكتروني",
                  iconData: Icons.email,
                  isNumber: false,
                  mycontroller: controller.email,
                  valid: (val) {
                    return vaildInput(val, 2, 30);
                  },
                ),
                const SizedBox(height: 10),
                // كلمة المرور
                CustomRegisterAuth1(
                  hinttext: "كلمة المرور",
                  mycontroller: controller.password,
                  obscureText: true,
                  valid: (val) {
                    return vaildInput(val, 2, 30);
                  },
                ),
                const SizedBox(height: 10),
                // تأكيد كلمة المرور
                CustomRegisterAuth2(
                  hinttext: "تأكيد كلمة المرور",
                  mycontroller: controller.repassword,
                  obscureText: true,
                  valid: (val) {
                    return vaildInput(val, 2, 30);
                  },
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.only(top: screenWidth(25)),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.SignUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 22,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // تعيين حواف دائرية هنا
                      ),
                      padding: EdgeInsets.zero, // لون الخلفية هنا
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // نفس شكل الحواف هنا
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: screenWidth(3),
                            minHeight: screenWidth(6.6)),
                        alignment: Alignment.center,
                        child: controller.isLoading == true
                            ? const CircularProgressIndicator(
                                color: Color.fromARGB(205, 42, 108, 139),
                              )
                            : const Text(
                                "انشاء حساب",
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
              ],
            ),
          ),
        );
      }),
    );
  }
}
