import 'package:api2/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
class LoginController extends GetxController{
   
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
String _message = "";

Future<void> submit() async{
  User user = User(username: username.text.trim(), password: password.text.trim());

  bool validateResult = ValidateUser(user);

  if(validateResult) {
    bool serverResponse = await authenticateUser(user);
    if(serverResponse){
      await showMessage(
      context: Get.context!,
       title: 'Success',
        message: 'User Login Successfully!');

    }else{
        await showMessage(
      context: Get.context!, 
      title: 'Error',
       message: 'Incorrect Username or Password');


    }
  }else{
    await showMessage(
      context: Get.context!,
       title: 'Error',
        message: _message);

  }
}

//Validating username and password
bool ValidateUser(User user){
  if(user.username == null || user.password == null){
    _message = 'Username or password cannot be empty';
    return false;
  }
  if(user.username.toString().isEmpty){
    _message = "Username cannot be empty";
    return false;
  }
  if(user.password.toString().isEmpty){
    _message = "password cannot be empty";
    return false;
  }
  return true;
}
Future<bool> authenticateUser(User user) async{
  Dio dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 5)));
  String _apiUrl = "https://dummyjson.com/auth/login";

  try {
    Map<String, dynamic> requestData = {
      'username' : user.username,
      'password' : user.password
    };
    final response = await dio.post(_apiUrl, data: requestData);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  } catch (e) {
    return false;
  }
}



//Display Dialog box code
showMessage({required BuildContext context, required String title, required String message}){
  showCupertinoDialog(context: context, builder: (context){
 return CupertinoAlertDialog(
  title: Text(title),
  content: Text(message),
  actions: [
    CupertinoDialogAction(child: Text('OK'), onPressed: (){
      Get.back();
    },)
  ],
 );
  });
}
}