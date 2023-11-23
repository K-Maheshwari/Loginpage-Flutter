import 'package:flutter/material.dart';
import 'package:login/Screens/Forgot_pwd/components/forgot_pwd_top_image.dart';
import 'package:login/constants.dart';
import 'package:login/responsive.dart';
import '../../components/background.dart';
import 'package:login/Screens/Forgot_pwd/components/forgot_pwd_form.dart';
//import 'components/socal_sign_up.dart';

class ForgotPwdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: ForgotPwdTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: ForgotPwdForm(),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ForgotPwdTopImage(),
          Row(
            children:  [
              Spacer(),
              Expanded(
                flex: 8,
                child: ForgotPwdForm(),
              ),
              Spacer(),
            ],
          ),
          // const SocalSignUp()
        ],
      ),
    );
  }
}