import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kgamify/utils/validator_constants.dart';

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
            Expanded(flex: 1,child: Container(
              color: Colors.yellow,
            ),
            ),
            Expanded(flex: 2,child: Container(
              color: Colors.orangeAccent,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.03),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Email")
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

                      decoration: const InputDecoration(
                        label: Text("Password")
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
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                    ), child: const Text("Validate"),
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
