import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/screens/onboarding/emailaddressscreen.dart';
import 'package:mememates/screens/onboarding/namescreen.dart';
import 'dart:io' show Platform;
import 'package:mememates/utils/authentication/firebase.dart';
import 'package:mememates/utils/providers/userprovider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final logo = SvgPicture.asset(
    'assets/logo.svg',
    height: 200.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  logo,
                  const Text(
                    "Forget the small talk, let's meme about it.",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF999999),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const EmailAddressScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFE94158),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Text(
                      'Continue with email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 16,
                          ),
                          child: Divider(
                            color: Color(
                              0xFF9CA3AF,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "or continue with",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(
                            0xFF9CA3AF,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 16,
                          ),
                          child: Divider(
                            color: Color(
                              0xFF9CA3AF,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            dynamic data = await FireAuth().signInWithGoogle();
                            if (data.runtimeType == String || data == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    data,
                                  ),
                                ),
                              );
                            } else {
                              final userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);
                              userProvider.updateUser(
                                userProvider.user!.copyWith(
                                  email: data.email,
                                  uid: data.uid,
                                  name: data.displayName,
                                  isEmailVerified: true,
                                ),
                              );
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const NameScreen(),
                                ),
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            side: BorderSide(
                              color: Color(0xffE94158),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Brand(
                                Brands.google,
                                size: 24,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Google',
                                style: TextStyle(
                                  color: Color(0xFF374151),
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (Platform.isIOS)
                        SizedBox(
                          width: 16,
                        ),
                      if (Platform.isIOS)
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              side: BorderSide(
                                color: Color(0xffE94158),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  BoxIcons.bxl_apple,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Apple',
                                  style: TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
