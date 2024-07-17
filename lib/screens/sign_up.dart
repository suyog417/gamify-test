import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kgamify/utils/exports.dart';
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
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(flex: 3,child: Container(
              width: MediaQuery.sizeOf(context).width,
              color: Colors.orange,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: "k\n",
                  style: TextStyle(
                    fontSize: 92,
                    fontWeight: FontWeight.w900
                  ),
                  children: [
                    TextSpan(
                        text: "kGamify",
                      style: TextStyle(
                        fontSize: 28
                      )
                    ),
                  ]
                ),
              )
            ),
            ),
            Expanded(flex: 4,child: Container(
              color: Colors.white,
              child: Padding(
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
                        if(value == null || value == ""){
                          return "Email field can't be empty.";
                        }
                        if(EmailValidator.validate(value)){
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
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.password),
                        border: const OutlineInputBorder()
                      ),
                      obscureText: true,
                    ),
                    const Divider(),
                    ElevatedButton(onPressed: () {
                      if(formKey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Form is valid.")));
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter valid details.")));
                      }
                    },
                    style: elevatedButtonTheme(context),
                      child: Text(AppLocalizations.of(context)!.validate),
                    )
                  ],
                ),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}
