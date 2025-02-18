import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mememates/screens/main_screen.dart';
import 'package:mememates/screens/onboarding/verification_screen.dart';
import 'package:mememates/utils/authentication/emailverification.dart';
import 'package:mememates/utils/authentication/firebase.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hasError = false;
  String errorMessage = '';
  bool isProcessing = false;

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void handleSubmit() async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        hasError = true;
        errorMessage = "Please enter an email address and password";
      });
      setState(() {
        isProcessing = false;
      });
      return;
    }

    bool isInvalidEmail = !RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(emailController.text);
    if (isInvalidEmail) {
      setState(() {
        errorMessage = "Please enter a valid email address";
        hasError = true;
      });
      return;
    }
    setState(() {
      hasError = false;
    });
    var data = await FireAuth().createUserWithEmailAndPassword(
        emailController.text, passwordController.text);
    if (data != true) {
      if (data.runtimeType == String) {
        if (data == "email-already-in-use") {
          var signInData = await FireAuth().signInWithEmailAndPassword(
              emailController.text, passwordController.text);
          if (signInData != true) {
            if (signInData.runtimeType == String) {
              if (signInData == 'wrong-password') {
                setState(() {
                  errorMessage = 'Incorrect password. Please try again.';
                  hasError = true;
                });
              } else {
                setState(() {
                  errorMessage = signInData;
                  hasError = true;
                });
              }
              return;
            }
          }
          if (signInData == true) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          }
        }
        if (data == "weak-password") {
          setState(() {
            errorMessage = 'Password is too weak. Please try again.';
            hasError = true;
          });
          return;
        }
      } else {
        setState(() {
          errorMessage = data;
          hasError = true;
        });
        return;
      }
    }
    if (data == true) {
      bool isEmailSent = await EmailVerification().send(emailController.text);
      if (isEmailSent) {
        setState(() {
          isProcessing = false;
        });
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => VerificationScreen(
              emailaddress: emailController.text,
            ),
          ),
        );
      } else {
        setState(() {
          errorMessage = "Something went wrong, please try again later.";
          hasError = true;
        });
      }
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
                    value: 11 / 100,
                    color: Color(0xFFe94158),
                    backgroundColor: Color(0xFFE3E5E5),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "What's your email address?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CupertinoTextField(
                    autofocus: true,
                    controller: emailController,
                    placeholder: "Email Address",
                    placeholderStyle: TextStyle(
                      color: Color(0xFF090A0A),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.all(
                      16,
                    ),
                    onChanged: (value) {
                      if (hasError) {
                        setState(() {
                          hasError = false;
                        });
                      }
                    },
                    style: TextStyle(
                      color: Color(0xFF090A0A),
                      fontSize: 18,
                      letterSpacing: 0.2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(
                          0xFFE3E5E5,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CupertinoTextField(
                    autofocus: true,
                    controller: passwordController,
                    placeholder: "Password",
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    placeholderStyle: TextStyle(
                      color: Color(0xFF090A0A),
                    ),
                    padding: EdgeInsets.all(
                      16,
                    ),
                    onChanged: (value) {
                      if (hasError) {
                        setState(() {
                          hasError = false;
                        });
                      }
                    },
                    style: TextStyle(
                      color: Color(0xFF090A0A),
                      fontSize: 18,
                      letterSpacing: 0.4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(
                          0xFFE3E5E5,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  hasError
                      ? Text(
                          errorMessage,
                          style: TextStyle(
                            color: Color(0xFFE94158),
                            fontSize: 14,
                          ),
                        )
                      : Text(
                          "We'll send you a code to verify it's really you.",
                          style: TextStyle(
                            color: Color(0xFF7D7D7D),
                            fontSize: 14,
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 32,
                ),
                child: TextButton(
                  onPressed: handleSubmit,
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
                  child: isProcessing
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
