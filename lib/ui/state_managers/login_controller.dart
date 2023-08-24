import 'package:get/get.dart';

import '../../data/models/auth_utility.dart';
import '../../data/models/login_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../screens/bottom_nav_base_screen.dart';

class LoginController extends GetxController{
  bool _loginInProgress = false;

  bool get loginInProgress => _loginInProgress;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.login, requestBody);
    _loginInProgress = false;

     update();
    if (response.isSuccess) {
      await Authutility.saveUserInfo(LoginModel.fromJson(response.body!));
      return true; }
     else {
      return false;
    }
  }
}
