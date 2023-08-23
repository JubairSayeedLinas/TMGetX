import 'package:flutter/material.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';
import 'package:tm_getx/ui/screens/auth/otp_verification_screen.dart';
import 'package:tm_getx/ui/screens/auth/otp_verification_screen.dart';
import 'package:tm_getx/ui/widgets/screen_background.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _emailVerificationInProgress = false;
  final TextEditingController _emailTEController = TextEditingController();

  Future<void> sendOTPtoEmail() async {
    _emailVerificationInProgress = true;
    if(mounted){
      setState(() {

      });
    }

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.sendOtpToEmail(_emailTEController.text.trim()));
    _emailVerificationInProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.isSuccess){
      if(mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            OtpVerificationScreen(email: _emailTEController.text.trim())));
      } else {
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(' Emaill Verification Failed')));
        }
        }
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48,
                ),
                Text(
                  'Your Email Address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'A 6 digit pin will send to your email address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _emailVerificationInProgress == false,
                    replacement: const Center (child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {
                          sendOTPtoEmail();
                        }, child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have An Account?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.6
                      ),
                    ),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Sign In'))
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
