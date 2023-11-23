import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login/Screens/Forgot_pwd/forgot_pwd_screen.dart';
import 'package:login/Screens/Signup/components/signup_form.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {


  final _formKey = GlobalKey<FormState>();
  bool pwdVisible=true;

  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  void clearText() {
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  void login(String email , password) async {
    try{
      Response response = await post(
          Uri.parse('https://vinsupinfotech.com/FMS/public/api/login'),
          body: {
            'email' : email,
            'password' : password
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        clearText();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Login Successfully'
            ),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      }else{
        print('Failed');
        if(response.statusCode == 401){
          print('Account not registered');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Please check your email and password'
              ),
              backgroundColor: primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Login Failed'
              ),
              backgroundColor: primaryColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
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
        children: [
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
                padding:  EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: pwdVisible,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                errorStyle: TextStyle(color: primaryColor),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                // suffixIcon: Icon(Icons.remove_red_eye_rounded,color: primaryColor,)
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
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForgotPwdScreen();
                  },
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: defaultPadding*3),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Logging In'),backgroundColor: primaryColor,),
                  // );
                }
                login(emailcontroller.text.toString(),passwordcontroller.text.toString());
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          SizedBox(height: defaultPadding*3),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(height: defaultPadding*4),
        ],
      ),
    );
  }
}