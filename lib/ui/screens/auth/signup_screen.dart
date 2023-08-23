import 'package:flutter/material.dart';
import 'package:tm_getx/data/models/network_response.dart';
import 'package:tm_getx/data/services/network_caller.dart';
import 'package:tm_getx/data/utils/urls.dart';
import 'package:tm_getx/ui/screens/email_verfication_screen.dart';
import 'package:tm_getx/ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  bool _signUpProgress = false;

  void userSignUp() async {
    _signUpProgress = true;
     if(mounted){
       setState(() {

       });
     }
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text.trim(),
      "photo":""
    };

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.registration, requestBody);
    _signUpProgress = false;
    if(mounted){
      setState(() {

      });
    }
    if(response.isSuccess){
      _emailTEController.clear();
      _passwordTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(' Registration Success')));
      }
    }
    else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(' Registration Failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    Text(
                      'Join With Us',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (String ? value){
                        if (value?.isEmpty ?? true){
                          return 'Enter Your Email';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _firstNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'First Name'),
                      validator: (String ? value){
                        if (value?.isEmpty ?? true){
                          return 'Enter Your First Name';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Last Name'),
                      validator: (String ? value){
                        if (value?.isEmpty ?? true){
                          return 'Enter Your Last Name';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   TextFormField(
                     controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Mobile'),
                     validator: (String ? value){
                       if ((value?.isEmpty ?? true) || value!.length < 11){
                         return 'Enter Your Valid Mobile Number';
                       }
                     },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordTEController,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String ? value){
                        if ((value?.isEmpty ?? true) || value!.length <= 5){
                          return 'Enter More Than 6 letters';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpProgress == false,
                        replacement: Center(child: const CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if(!_formKey.currentState!.validate()){
                                   return;
                              }
                              userSignUp();
                            }, child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailVerificationScreen()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          )),
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
