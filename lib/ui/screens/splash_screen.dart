import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm_getx/data/models/auth_utility.dart';
import 'package:tm_getx/ui/screens/auth/login_screen.dart';
import 'package:tm_getx/ui/screens/bottom_nav_base_screen.dart';
import 'package:tm_getx/ui/utils/assets_utils.dart';
import 'package:tm_getx/ui/widgets/screen_background.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await Authutility.checkIfUserLoogedIn();
      if(mounted){
        Get.offAll( () => isLoggedIn ? const BottomNavScreen() : const LoginScreen());
      }
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             isLoggedIn ? const BottomNavScreen() : const LoginScreen()),
      //     (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: Center(
        child: SvgPicture.asset(
          AssetsUtils.logoSVG,
          width: 80,
          fit: BoxFit.scaleDown,
        ),
      ),
    ));
  }
}
