// ignore_for_file: file_names, unused_local_variable

import 'package:courseproject/controller/login_controller.dart';
import 'package:courseproject/static/utils.dart';
import 'package:courseproject/static/valid.dart';
import 'package:courseproject/widgets/auth/custombodyauth.dart';
import 'package:courseproject/widgets/auth/custombuttonauth.dart';
import 'package:courseproject/widgets/auth/customtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return controller.isLoading == false
        ? Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth(16), vertical: screenHeight(50)),
            child: GetBuilder<LoginControllerImp>(
              builder: (controller) {
                return Form(
                  key: controller.formState,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Image.asset(
                        "assets/images/img1.png",
                        width: 200,
                      ),
                      SizedBox(
                        height: screenWidth(30),
                      ),
                      const Text(
                        'Login As Adminstrator',
                      ),
                      SizedBox(
                        height: screenHeight(40),
                      ),
                      CustomBodyAuth(
                          text: 'Sign In Your Email And Password'.tr),
                      SizedBox(
                        height: screenHeight(30),
                      ),
                      CustomTextFormAuth(
                        hinttext: "Enter Your Email",
                        iconData: Icons.email_outlined,
                        isNumber: false,
                        labeltext: "Email",
                        mycontroller: controller.email,
                        valid: (val) {
                          return vaildInput(val, 2, 30);
                        },
                      ),
                      CustomTextFormAuth(
                        hinttext: "Enter Your Password",
                        iconData: Icons.lock_outline,
                        isNumber: false,
                        labeltext: "Password",
                        mycontroller: controller.password,
                        obscureText: true,
                        valid: (val) {
                          return vaildInput(val, 2, 30);
                        },
                      ),
                      const Text(
                        "Forget Password?",
                        textAlign: TextAlign.end,
                      ),
                      CustomButtomAuth(
                        text: "Sign In",
                        onPressed: () {
                          controller.login(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ))
        : const CircularProgressIndicator();
  }
}
