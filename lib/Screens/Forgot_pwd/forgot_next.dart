import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:login/Screens/Forgot_pwd/components/forgot_pwd_form.dart';
import 'dart:async';
import '../../components/background.dart';
import 'package:http/http.dart' as http;
import 'package:login/constants.dart';
import '../../get_otp_resp_data.dart';
import '../Change_pwd/change_pwd_screen.dart';

class Verification extends StatefulWidget {

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  late var userId;

  TextEditingController otpController1=TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  void clearText() {
    otpController1.clear();
    otpController2.clear();
    otpController3.clear();
    otpController4.clear();
    otpController5.clear();
    otpController6.clear();
  }

  final _formKey = GlobalKey<FormState>();

  void otp(String email, otp) async {
    try {
      var getotpuri =  Uri.https('www.vinsupinfotech.com','/FMS/public/api/get_otp', {'email': email, 'otp': otp});
      debugPrint("${getotpuri}");
      http.Response response = await http.post(
          getotpuri

      );
      debugPrint("${response.body}");
      if (jsonDecode(response.body) == "OTP Invalid") {
        print('Failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Enter valid OTP',
            ),
            backgroundColor: primaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        try{
          var jsonDecodeResponse = jsonDecode(response.body);
          GetOtpRespData getOtpRespData = GetOtpRespData.fromJson(jsonDecodeResponse);
          userId=getOtpRespData.details?.userId;
          print(userId);
          if(getOtpRespData.status == 'OTP Valid'){
            print("OTP Verified");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Your User Id is : $userId',
                ),
                backgroundColor: primaryColor,
                duration: Duration(seconds: 8),
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Change_pwdScreen(),
              ),
            );
          }

        }catch(e){
          debugPrint(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // void otp(String email,otp) async {
  //   try{
  //     http.Response response = await http.post(
  //         Uri.parse('https://vinsupinfotech.com/FMS/public/api/get_otp'),
  //         body: {
  //           'email' : email,
  //           'otp' : otp
  //         }
  //     );
  //     if(response.statusCode == 200){
  //       print('Go to Change Pwd');
  //     }else {
  //       print('failed');
  //     }
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }

  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;
        if (_currentIndex == 3)
          _currentIndex = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 0 ? 1 : 0,
                            duration: Duration(seconds: 1,),
                            curve: Curves.linear,
                            child: Image.network('https://ouch-cdn2.icons8.com/eza3-Rq5rqbcGs4EkHTolm43ZXQPGH_R4GugNLGJzuo/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjk3/L2YzMDAzMWUzLTcz/MjYtNDg0ZS05MzA3/LTNkYmQ0ZGQ0ODhj/MS5zdmc.png',),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 1 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network('https://ouch-cdn2.icons8.com/pi1hTsTcrgVklEBNOJe2TLKO2LhU6OlMoub6FCRCQ5M/rs:fit:784:666/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMzAv/MzA3NzBlMGUtZTgx/YS00MTZkLWI0ZTYt/NDU1MWEzNjk4MTlh/LnN2Zw.png',),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: AnimatedOpacity(
                            opacity: _currentIndex == 2 ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.linear,
                            child: Image.network('https://ouch-cdn2.icons8.com/ElwUPINwMmnzk4s2_9O31AWJhH-eRHnP9z8rHUSS5JQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNzkw/Lzg2NDVlNDllLTcx/ZDItNDM1NC04YjM5/LWI0MjZkZWI4M2Zk/MS5zdmc.png',),
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(height: 30,),
                FadeInDown(
                    duration: Duration(milliseconds: 500),
                    child: Text("Verification", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: primaryColor),)),
                SizedBox(height: 30,),
                FadeInDown(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 500),
                  child: Text("Please enter the 6 digit code sent to \n your valid Email ID",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.5),),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myInputBox(context, otpController1),
                    myInputBox(context, otpController2),
                    myInputBox(context, otpController3),
                    myInputBox(context, otpController4),
                    myInputBox(context, otpController5),
                    myInputBox(context, otpController6)
                  ],
                ),
                // SizedBox(height: 20,),
                // FadeInDown(
                //   delay: Duration(milliseconds: 700),
                //   duration: Duration(milliseconds: 500),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text("Don't receive the OTP?", style: TextStyle(fontSize: 14, color: Colors.black54),),
                //       TextButton(
                //           onPressed: () {
                //             if (_isResendAgain) return;
                //             resend();
                //             final otps = otpController1.text +
                //                 otpController2.text +
                //                 otpController3.text +
                //                 otpController4.text +
                //                 otpController5.text +
                //                 otpController6.text;
                //             otp(ForgotPwdForm.emailcontroller.text.toString(), otps.toString());
                //           },
                //           child: Text(_isResendAgain ? "Try again in " + _start.toString() : "Resend", style: TextStyle(color: primaryColor),)
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: 65),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 500),
                  child: MaterialButton(
                    elevation: 0,
                    onPressed:  ()  {
                      final otps = otpController1.text +
                          otpController2.text +
                          otpController3.text +
                          otpController4.text +
                          otpController5.text +
                          otpController6.text;
                      if (_formKey.currentState!.validate()) {
                        if(otpController1.text.isEmpty || otpController2.text.isEmpty ||
                            otpController3.text.isEmpty || otpController4.text.isEmpty ||
                            otpController5.text.isEmpty || otpController6.text.isEmpty){
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Alert"),
                              content: const Text("Please enter valid code. Empty fields not allowed"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    // color: Colors.green,
                                    padding: const EdgeInsets.all(14),
                                    child: const Text("okay"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          otp(ForgotPwdForm.emailcontroller.text.toString(), otps.toString());
                        }
                      }
                      clearText();
                    } ,
                    color: primaryColor,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    child: _isLoading ? Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ) : _isVerified ? Icon(Icons.check_circle, color: Colors.white, size: 30,) : Text("Verify", style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(height:30.0),
              ],),
          ),
        ),
      ),
    );
  }
}

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 70,
    width: 55,
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 32),
        decoration: InputDecoration(
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        }),
  );
}