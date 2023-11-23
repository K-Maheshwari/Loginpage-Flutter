import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login/Screens/Forgot_pwd/forgot_next.dart';
import 'package:login/constants.dart';

class ForgotPwdForm extends StatefulWidget {
  static TextEditingController emailcontroller=TextEditingController();
  @override
  State<ForgotPwdForm> createState() => _ForgotPwdFormState();
}

class _ForgotPwdFormState extends State<ForgotPwdForm> {

  // void clearText() {
  //   ForgotPwdForm.emailcontroller.clear();
  // }

  final _formKey = GlobalKey<FormState>();

  void forgot(String email) async {
    try{
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/forgot'),
          body: {
            'email' : email,
          }
      );
      if(response.statusCode == 200){
        print('OTP sended');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Verification();
            },
          ),
        );
      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
          child: Column(
            children: [
              Text(
                "Please enter your email address to search for your account.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6F35A5),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            SizedBox(height:50.0),
            TextFormField(
            controller: ForgotPwdForm.emailcontroller,
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Enter your valid Email Id';
            //   }
            //   return null;
            // },
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email'
                  : null,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              errorStyle: TextStyle(color: primaryColor),
              prefixIcon: Padding(
                padding:  EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          SizedBox(height: defaultPadding*4),
          Hero(
            tag: "Done",
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  forgot(ForgotPwdForm.emailcontroller.text.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sending OTP'),backgroundColor: primaryColor,duration: Duration(seconds: 3),),
                  );
                }
               // clearText();
              },
              child: Text(
                "Next".toUpperCase(),
              ),
            ),
          ),
        ],
          ),
      ),
    );
  }
}
