import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kgamify/screens/landing_page.dart';
import 'package:kgamify/utils/validator_constants.dart';
import 'package:kgamify/utils/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final passNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _email.dispose();
    _passwordController.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: const Color(0xFFff8200),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFff8200),
                ),
                child: Image.asset("assets/images/KLOGO.png"),
              ),
              // const Divider(color: Colors.transparent,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create new account",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    AppTextField(
                      controller: _name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      label: "Full Name",
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    AppTextField(
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cannot be empty";
                        } else if (!UserValidation().regExp.hasMatch(value)) {
                          return "Enter valid email ex.example@abc.com";
                        }
                        return null;
                      },
                      label: "Email",
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    AppTextField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty.";
                        }
                        if (!UserValidation().passExp.hasMatch(value)) {
                          return '''
Password should contain
  should contain at least one upper case
  should contain at least one lower case
  should contain at least one digit
  should contain at least one Special character
  Must be at least 8 characters in length''';
                        }
                        return null;
                      },
                      label: "Password",
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    AppTextField(
                      validator: (value) {
                        if (value == null || _passwordController.text != value || value.isEmpty) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      focusNode: passNode,
                      suffix: passNode.hasFocus
                          ? const Icon(CupertinoIcons.eye_fill)
                          : const Icon(CupertinoIcons.eye_slash_fill),
                      label: "Confirm password",
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    FilledButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Hive.box("UserData").put("isLoggedIn", true);
                          Hive.box("UserData").put("personalInfo", {
                            "name": _name.text,
                            "email": _email.text,
                            "password": _passwordController.text
                          }).whenComplete(
                            () {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const LandingPage(),
                                  ));
                            },
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width)),
                      child: const Text("Create account"),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account?",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // print("clicked");
                              Navigator.pop(context);
                              // Navigator.push(context, CupertinoDialogRoute(builder: (context) => const SignUp(), context: context));
                            },
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
