import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:email_validator/email_validator.dart';

class SignUpForm extends StatefulWidget {

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

TextEditingController user_namecontroller=TextEditingController();
TextEditingController emailcontroller=TextEditingController();
TextEditingController passwordcontroller=TextEditingController();
TextEditingController c_passwordcontroller=TextEditingController();
TextEditingController fieldText=TextEditingController();

void clearText() {
  user_namecontroller.clear();
  emailcontroller.clear();
  passwordcontroller.clear();
  c_passwordcontroller.clear();
}

void signup(String name,email,password,c_password) async {
  try{
    http.Response response = await http.post(
        Uri.parse('https://vinsupinfotech.com/FMS/public/api/register'),
        body: {
          'name' : name,
          'email' : email,
          'password' : password,
          'c_password' : c_password
        }
    );
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('Account Created successfully');
    }else {
      print('failed');
    }
  }catch(e){
    print(e.toString());
  }
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  bool pwdVisible=true;
  bool pwdVisible1=true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: user_namecontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: "Your Name",
                errorStyle: TextStyle(color: primaryColor),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height:15.0),
            TextFormField(
              controller: emailcontroller,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your email';
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
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(

                controller: passwordcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                obscureText: pwdVisible,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  hintText: "Your password",
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
            ),
          TextFormField(
            controller: c_passwordcontroller,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Please enter your password';
              return null;
            },
            textInputAction: TextInputAction.done,
            obscureText: pwdVisible1,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              hintText: "Confirm your password",
              errorStyle: TextStyle(color: primaryColor),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
              // suffixIcon: Icon(Icons.remove_red_eye_rounded,color: primaryColor),
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
                }
              ),
            ),
          ),
            SizedBox(height: defaultPadding * 2),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && passwordcontroller.text == c_passwordcontroller.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Account created Successfully'),backgroundColor: primaryColor,duration: Duration(seconds: 1),),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                } else if (passwordcontroller.text !=
                    c_passwordcontroller.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            '"Password does not match. Please re-type again."'),
                        backgroundColor: primaryColor),
                  );
                }
                signup(
                    user_namecontroller.text.toString(),
                    emailcontroller.text.toString(),
                    passwordcontroller.text.toString(),
                    c_passwordcontroller.text.toString());
                clearText();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return LoginScreen();
                //     },
                //   ),
                // );
              },
              child: Text("Sign Up".toUpperCase()),
            ),
            SizedBox(height: defaultPadding*3),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: defaultPadding*5),
          ],
        ),
      ),
    );
  }
}