import 'package:api2/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                   fontWeight: FontWeight.bold,
                   color: Colors.purple
                   ),
                ),
               const SizedBox(
                  height: 30,
                ),
              InputBox(
                isSecured: false,
                hint: 'Username',
                 txtController: controller.username),
             const SizedBox(
                height: 20,
              ),
               InputBox(
                isSecured: true,
                hint: 'Password',
                 txtController: controller.password),
              const  SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Get.width / 2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                  print('login credentials =============== ');
                  //now we will create User Model and Validations
                 await controller.submit();
                },
                child: const Text('Login')),
              ),
            ],
          ),
        ),
      ),
      );
  }
}

Widget InputBox({required String hint, required TextEditingController txtController, required bool isSecured}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey),
    ),
   child: TextField(
         obscureText:isSecured,
    controller: txtController,
    decoration: InputDecoration(border: InputBorder.none, hintText: hint),
   ),
  );
}

