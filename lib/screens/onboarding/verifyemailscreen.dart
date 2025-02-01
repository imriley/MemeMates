import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mememates/screens/onboarding/namescreen.dart';
import 'package:mememates/utils/authentication/emailverification.dart';

class VerifyEmailScreen extends StatefulWidget {
  String emailaddress;
  VerifyEmailScreen({super.key, required this.emailaddress});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  List<String> otp = ["", "", "", "", "", ""];
  bool hasOTPError = false;

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              IconsaxOutline.arrow_left_2,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  LinearProgressIndicator(
                    value: 22 / 100,
                    color: Color(0xFFe94158),
                    backgroundColor: Color(0xFFE3E5E5),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Verification Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "We've sent you a verification code to",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF7D7D7D),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.emailaddress,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.only(
                          left: 4,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        sizeStyle: CupertinoButtonSize.small,
                        child: Text(
                          "Change email address?",
                          style: TextStyle(
                            color: Color(0xFFe94158),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              hasOTPError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              otp[0] = value;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              hasOTPError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              otp[1] = value;
                            } else if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              otp[1] = '';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              hasOTPError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              otp[2] = value;
                            } else if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              otp[2] = '';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              hasOTPError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              otp[3] = value;
                            } else if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              otp[3] = '';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              hasOTPError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              otp[4] = value;
                            } else if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              otp[4] = '';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              hasOTPError = false;
                            });
                            if (value.length == 1) {
                              otp[5] = value;
                            } else if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                              otp[5] = '';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF7D7D7D),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  hasOTPError
                      ? Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            "Please enter a valid OTP.",
                            style: TextStyle(
                              color: Color(0xFFE94158),
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 32,
                ),
                child: TextButton(
                  onPressed: () async {
                    if (otp.any((element) => element.isEmpty)) {
                      setState(() {
                        hasOTPError = true;
                      });
                    } else {
                      bool isVerified = await EmailVerification().verify(
                        otp.join(''),
                      );
                      if (!isVerified) {
                        setState(() {
                          hasOTPError = true;
                        });
                      } else {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => NameScreen(),
                          ),
                        );
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFE94158),
                    padding: EdgeInsets.all(
                      16,
                    ),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
