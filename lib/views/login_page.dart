// ignore_for_file: unused_local_variable

import 'package:courseproject/controller/LoginController.dart';
import 'package:courseproject/static/utils.dart';
import 'package:courseproject/static/valid.dart';
import 'package:courseproject/views/signup_page.dart';
import 'package:courseproject/widgets/mainauth/CustomLogin1.dart';
import 'package:courseproject/widgets/mainauth/customtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(16), vertical: screenHeight(70)),
        child: GetBuilder<LoginController>(
          builder: (controller) {
            return Form(
              key: controller.loginFormKey,
              child: ListView(
                children: [
                  Image.asset(
                    "assets/images/loglogo.jpg",
                    width: screenWidth(1.2),
                    height: screenWidth(1.2),
                  ),
                  SizedBox(
                    height: screenWidth(30),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenWidth(99)),
                    child: CustomTextFormAuth(
                      hinttext: "البريد الالكتروني",
                      iconData: Icons.email_outlined,
                      isNumber: false,
                      mycontroller: controller.email,
                      valid: (val) {
                        return vaildInput(val, 2, 30);
                      },
                    ),
                  ),
                  CustomLoginAuth1(
                    hinttext: "كلمة المرور",
                    mycontroller: controller.password,
                    obscureText: true,
                    valid: (val) {
                      return vaildInput(val, 2, 30);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.reset(context);
                          },
                          child: const Text(
                            "اضغط هنا",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color.fromARGB(184, 7, 52, 112),
                            ),
                          ),
                        ),
                        const Text(
                          " نسيت كلمة المرور؟",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 22,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: GetBuilder<LoginController>(builder: (controller) {
                      return Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: screenWidth(3),
                              minHeight: screenWidth(6.6)),
                          alignment: Alignment.center,
                          child: controller.isloading2
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "تسجيل دخول",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "cairo",
                                      fontSize: 16),
                                ),
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth(20)),
                    child: Obx(() => MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          height: 50,
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  controller.signInWithGoogle(context);
                                },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/google.png",
                                      width: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "تسجيل الدخول بحساب جوجل",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const SignupPage());
                          },
                          child: const Text(
                            "انشاء حساب",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromARGB(184, 7, 52, 112),
                            ),
                          ),
                        ),
                        const Text(
                          " ليس لديك حساب؟",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
