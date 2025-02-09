import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mememates/screens/onboarding/gender_screen.dart';
import 'package:mememates/utils/providers/userprovider.dart';
import 'package:provider/provider.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final List<String> _day = ['', ''];
  final List<String> _month = ['', ''];
  final List<String> _year = ['', '', '', ''];
  bool hasError = false;
  String errorMessage = "";

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
                          autofocus: true,
                          onChanged: (value) {
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _day[0] = value;
                              });
                            } else {
                              setState(() {
                                _day[0] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _day[1] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _day[1] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _month[0] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _month[0] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _month[1] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _month[1] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _year[0] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _year[0] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _year[1] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _year[1] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              setState(() {
                                _year[2] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _year[2] = '';
                              });
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
                            setState(() {
                              hasError = false;
                            });
                            if (value.length == 1) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                _year[3] = value;
                              });
                            } else {
                              FocusScope.of(context).previousFocus();
                              setState(() {
                                _year[3] = '';
                              });
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
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  hasError
                      ? Text(errorMessage,
                          style: TextStyle(
                            color: Color(0xFFE94158),
                            fontSize: 16,
                          ))
                      : Text(
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
                  onPressed: () {
                    if (_day.any((element) => element.isEmpty) ||
                        _month.any((element) => element.isEmpty) ||
                        _year.any((element) => element.isEmpty)) {
                      setState(() {
                        hasError = true;
                        errorMessage = 'Please enter your date of birth.';
                      });
                      return;
                    }

                    int day = int.parse(_day.join(''));
                    int month = int.parse(_month.join(''));
                    int year = int.parse(_year.join(''));

                    if (day > 31 || month > 12) {
                      setState(() {
                        hasError = true;
                        errorMessage = 'Please enter a valid date of birth.';
                      });
                      return;
                    }

                    if (month < 1 || month > 12) {
                      setState(() {
                        hasError = true;
                        errorMessage = 'Invalid month.';
                      });
                      return;
                    }
                    int daysInMonth = DateUtils.getDaysInMonth(year, month);
                    if (day < 1 || day > daysInMonth) {
                      setState(() {
                        hasError = true;
                        errorMessage = 'Invalid day for the selected month.';
                      });
                      return;
                    }

                    try {
                      DateTime dateOfBirth = DateTime(year, month, day);
                      int age = DateTime.now().year - dateOfBirth.year;

                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      userProvider.updateUser(userProvider.user!
                          .copyWith(dateOfBirth: dateOfBirth, age: age));

                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => GenderScreen(),
                        ),
                      );
                    } catch (e) {
                      setState(() {
                        hasError = true;
                        errorMessage = 'Please enter a valid date of birth.';
                      });
                      return;
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
