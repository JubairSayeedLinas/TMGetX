import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_getx/data/models/login_model.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';
import 'package:tm_getx/ui/screens/bottom_nav_base_screen.dart';
import 'package:tm_getx/ui/screens/email_verfication_screen.dart';
import 'package:tm_getx/ui/screens/auth/signup_screen.dart';
import 'package:tm_getx/ui/state_managers/login_controller.dart';
import 'package:tm_getx/ui/widgets/screen_background.dart';
import 'package:tm_getx/data/models/auth_utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  //final LoginController loginginController = Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<LoginController>(builder: (loginController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: loginController.loginInProgress == false,
                      replacement:
                          Center(child: const CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            loginController
                                .login(_emailTEController.text.trim(),
                                    _passwordTEController.text.trim())
                                .then((result) {
                                  if(result==true){
                                  Get.offAll(const BottomNavScreen());
                            } else {
                                    Get.snackbar('Failed', 'Login Failed! Try Again');
                                  }
                                });
                          },
                          child: Icon(Icons.arrow_forward_ios)),
                    ),
                  );
                }),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EmailVerificationScreen()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have An Account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.6),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text('Sign Up'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
