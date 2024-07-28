import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kgamify/screens/sign_in.dart';
import 'package:kgamify/utils/exports.dart';
import 'package:kgamify/utils/validator_constants.dart';
import 'package:kgamify/utils/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(FocusManager.instance.primaryFocus!.hasFocus){
      FocusManager.instance.primaryFocus!.unfocus();
    }
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.3,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.orange,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: "k\n",
                  style: TextStyle(
                    fontSize: 102,
                    fontWeight: FontWeight.w900
                  ),
                  children: [
                    TextSpan(
                        text: "kGamify",
                      style: TextStyle(
                        fontSize: 38
                      )
                    ),
                  ]
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: AppBar().preferredSize.height /2,),
                  Text(AppLocalizations.of(context)!.signUp,textAlign: TextAlign.start,style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w700
                  ),),
                  const Divider(color: Colors.transparent,),
                  TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.email),
                      border: const OutlineInputBorder(),
                    ),
                    controller: _emailController,
                    autofillHints: const [
                      AutofillHints.email
                    ],
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "Email field can't be empty.";
                      }
                      else if(UserValidation().regExp.hasMatch(value)){
                        return "Enter an valid email.";
                      }
                      return null;
                    },
                  ),
                  const Divider(color: Colors.transparent,),
                  TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    validator: (value) {
                      if(value == null){
                        return "Enter valid password";
                      }
                      return "";
                    },
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.password),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black.withOpacity(0.5),width: 0.0))
                    ),
                    obscureText: true,
                  ),
                  const Divider(color: Colors.transparent,),
                  ElevatedButton(onPressed: () {
                    if(Hive.box("UserData").get('personalInfo',defaultValue: null) != null){
                      if(formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Form is valid.")));
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid details.")));
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User doesnt exist.")));
                    }
                  },
                  style: elevatedButtonTheme(context),
                    child: Text(AppLocalizations.of(context)!.validate),
                  ),
                  const Divider(color: Colors.transparent,),
                  Text.rich(TextSpan(
                    text: "Don't have an account?",
                    recognizer: TapGestureRecognizer()..onTap = () {
                      // print("clicked");
                      Navigator.push(context, CupertinoDialogRoute(builder: (context) => const SignIn(), context: context));
                    },
                  ),textAlign: TextAlign.center,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
