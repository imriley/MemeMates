import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Birthdayscreen extends StatefulWidget {
  const Birthdayscreen({super.key});

  @override
  State<Birthdayscreen> createState() => _BirthdayscreenState();
}

class _BirthdayscreenState extends State<Birthdayscreen> {
  @override
  Widget build(BuildContext context) {
    void removeFocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {},
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
                    value: 44 / 100,
                    color: Color(0xFFe94158),
                    backgroundColor: Color(0xFFE3E5E5),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "When's your b-day?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'D',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'D',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                      ),
                      Text(
                        '/',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF7D7D7D),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'M',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'M',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                      ),
                      Text(
                        '/',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF7D7D7D),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Y',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Y',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Y',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                        width: 24,
                        child: TextField(
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            hintText: 'Y',
                            hintStyle: TextStyle(
                              color: Color(0xFF7D7D7D),
                            ),
                            contentPadding: EdgeInsets.all(0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 20,
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
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Your profile will show your age, not your date of birth.',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 32,
                ),
                child: TextButton(
                  onPressed: () {},
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
