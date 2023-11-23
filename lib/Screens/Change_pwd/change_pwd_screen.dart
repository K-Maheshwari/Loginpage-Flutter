import 'package:flutter/material.dart';
import 'package:login/constants.dart';
import 'package:login/responsive.dart';
import '../../components/background.dart';
import 'components/change_pwd_top_image.dart';
import 'components/change_pwd_form.dart';
//import 'components/socal_sign_up.dart';

class Change_pwdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Change_pwdScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: Change_pwdForm(),
                    ),
                    SizedBox(height: defaultPadding / 2),
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
          Change_pwdScreenTopImage(),
          Row(
            children:  [
              Spacer(),
              Expanded(
                flex: 8,
                child: Change_pwdForm(),
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