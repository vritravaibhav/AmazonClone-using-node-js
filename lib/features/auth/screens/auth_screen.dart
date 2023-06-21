import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/common/widgets/textfield.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:amazonclone/features/auth/services/auth_services.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _emailController.dispose();
    // _passController.dispose();
    // _passController.dispose();
  }

  void signUpuser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        name: _nameController.text,
        password: _passController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Welcome ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              title: (Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Form(
                key: _signUpFormKey,
                child: Column(children: [
                  CustomTextfield(
                    label: "Name",
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    label: "Email",
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    label: "Password",
                    controller: _passController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AmazonButton(
                    name: "Sign up",
                    onTap: () {
                      signUpuser();
                    },
                  ),
                ]),
              ),
            ListTile(
              title: (Text(
                "Sign in",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Form(
                key: _signUpFormKey,
                child: Column(children: [
                  // CustomTextfield(
                  //   label: "Name",
                  //   controller: _nameController,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    label: "Email",
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    label: "Password",
                    controller: _passController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AmazonButton(
                    name: 'Sign in',
                    onTap: () {
                      signInUser();
                    },
                  ),
                ]),
              ),
          ],
        ),
      )),
    );
  }
}
