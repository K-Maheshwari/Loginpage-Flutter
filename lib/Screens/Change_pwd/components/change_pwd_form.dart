import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class Change_pwdForm extends StatefulWidget {

  @override
  State<Change_pwdForm> createState() => _Change_pwdFormState();
}

class _Change_pwdFormState extends State<Change_pwdForm> {

  TextEditingController user_idcontroller=TextEditingController();
  TextEditingController pwdcontroller=TextEditingController();
  TextEditingController c_pwdcontroller=TextEditingController();

  void clearText() {
    user_idcontroller.clear();
    pwdcontroller.clear();
    c_pwdcontroller.clear();
  }

  final _formKey = GlobalKey<FormState>();
  bool pwdVisible=true;
  bool pwdVisible1=true;

  void Change_PWD(String user_id, password) async {
    try{
      http.Response response = await http.post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/change_password'),
          body: {
            'user_id' : user_id,
            'password' : password
          }
      );
      if(response.statusCode == 200){
          print('Password Changed Successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Password changed successfully'),
                backgroundColor: primaryColor),
          );
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );

      }else {
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please check your User ID'),backgroundColor: primaryColor,duration: Duration(seconds: 1),),
        );
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: user_idcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your User ID';
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              hintText: "Your User ID",
              errorStyle: TextStyle(color: primaryColor),
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(height:15.0),
          TextFormField(
            controller: pwdcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: pwdVisible,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              hintText: "Enter Password",
              errorStyle: TextStyle(color: primaryColor),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
              suffixIcon: IconButton(
                icon: Icon(pwdVisible
                    ? Icons.visibility
                    : Icons.visibility_off,color: primaryColor,),
                onPressed: () {
                  setState(
                        () {
                      pwdVisible = !pwdVisible;
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: c_pwdcontroller,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter your password';
                return null;
              },
              textInputAction: TextInputAction.next,
              obscureText: pwdVisible1,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: "Re-type password",
                errorStyle: TextStyle(color: primaryColor),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  icon: Icon(pwdVisible1
                      ? Icons.visibility
                      : Icons.visibility_off,color: primaryColor,),
                  onPressed: () {
                    setState(
                          () {
                        pwdVisible1 = !pwdVisible1;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding * 2),
          ElevatedButton(
            onPressed: () {
      if (_formKey.currentState!.validate()) {
        if (pwdcontroller.text !=
            c_pwdcontroller.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    '"Password does not match. Please re-type again."'),
                backgroundColor: primaryColor),
          );
        }
        else{
          Change_PWD(user_idcontroller.text.toString(), pwdcontroller.text.toString());
        }
      }
      clearText();
      },
            child: Text("Reset Password".toUpperCase()),
          ),
          SizedBox(height: defaultPadding*3),
        ],
      ),
    );
  }
}