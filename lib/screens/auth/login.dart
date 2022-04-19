import 'package:flutter/material.dart';
import 'package:lms_edutekzila/screens/auth/signup.dart';

import '../../utils/methods.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/rounded_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Within the `FirstRoute` widget

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height * 0.05,
                //   ),
                //   child: Image.asset("assets/kalakart-icon-2.png"),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: const Text(
                    "Log-In",
                    style: TextStyle(
                      // color: Colors.white,
                      // fontFamily: "Avenir",
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomInput(
                    title: "Email",
                    ctrl: _emailCtrl,
                    isObscure: false,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: passwordFocus,
                    focusNode: emailFocus,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomInput(
                  isObscure: true,
                  title: "Password",
                  ctrl: _passwordCtrl,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  nextFocusNode: FocusNode(canRequestFocus: false),
                  focusNode: passwordFocus,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2,
                    top: 10,
                  ),
                  child: GestureDetector(
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "reset-password");
                      // not made
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: RoundedButton(
                    bWidth: MediaQuery.of(context).size.width / 1.5,
                    bFunction: () async {
                      // print("Clicked");
                      Methods.showLoaderDialog(context);
                      firebaseAuth
                          .signInWithEmailAndPassword(
                              email: _emailCtrl.text,
                              password: _passwordCtrl.text)
                          .then((valueUser) {
                        if (valueUser.user != null) {
                          Navigator.pop(context);
                          return Navigator.pushNamed(
                            context,
                            widget.role == "mentor"
                                ? "mentor-home"
                                : "student-home",
                          );
                        } else {}
                      });
                    },
                    bText: "Sign In",
                    textColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: MediaQuery.of(context).size.width / 5.5,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                          // color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        child: const Text(
                          "Sign-up",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(role: widget.role),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
