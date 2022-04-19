import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lms_edutekzila/widgets/custom_input.dart';
import 'package:lms_edutekzila/widgets/rounded_button.dart';

import 'package:lms_edutekzila/utils/methods.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final FocusNode fNameFocus = FocusNode();
  final FocusNode lNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    "Sign Up",
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
                    title: "First Name",
                    ctrl: fName,
                    isObscure: false,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    nextFocusNode: lNameFocus,
                    focusNode: fNameFocus,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomInput(
                  title: "Last Name",
                  ctrl: lName,
                  isObscure: false,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  focusNode: lNameFocus,
                  nextFocusNode: emailFocus,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomInput(
                  title: "Email",
                  ctrl: _emailCtrl,
                  isObscure: false,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: emailFocus,
                  nextFocusNode: passwordFocus,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomInput(
                  isObscure: true,
                  title: "Password",
                  ctrl: _passwordCtrl,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  focusNode: passwordFocus,
                  nextFocusNode: FocusNode(),
                ),
                const SizedBox(
                  height: 25,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: RoundedButton(
                    bWidth: MediaQuery.of(context).size.width / 1.5,
                    bFunction: () async {
                      //implement sign up
                      Methods.showLoaderDialog(context);
                      firebaseAuth
                          .createUserWithEmailAndPassword(
                        email: _emailCtrl.text,
                        password: _passwordCtrl.text,
                      )
                          .then((value) {
                        if (value.user != null) {
                          firebaseAuth
                              .signInWithEmailAndPassword(
                            email: _emailCtrl.text,
                            password: _passwordCtrl.text,
                          )
                              .then((value) {
                            Navigator.pop(context);
                            return Navigator.pushNamed(
                                context,
                                widget.role == "mentor"
                                    ? "mentor-home"
                                    : "student-home");
                          });
                        }
                      });
                    },
                    bText: "Sign Up",
                    textColor: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    left: MediaQuery.of(context).size.width / 4.5,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Have an account ? ",
                        style: TextStyle(
                          // color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        child: const Text(
                          "Log-in",
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
