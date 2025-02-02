import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/screens/onboarding/setprofilepicture.dart';
import 'package:mememates/utils/providers/userprovider.dart';
import 'package:provider/provider.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String _selectedValue = '';
  bool hasError = false;
  double preferenceAgeMin = 18;
  double preferenceAgeMax = 24;
  late UserProvider userProvider;

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    int minAge = userProvider.user?.age != null
        ? userProvider.user!.age! - 2 >= 18
            ? userProvider.user!.age! - 2
            : 18
        : 18;

    setState(() {
      preferenceAgeMin = minAge.toDouble();
      preferenceAgeMax = preferenceAgeMin + 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  value: 66 / 100,
                  color: Color(0xFFe94158),
                  backgroundColor: Color(0xFFE3E5E5),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Who are you looking for?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = 'woman';
                      hasError = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    backgroundColor: _selectedValue == 'woman'
                        ? Color(0xFFE94158)
                        : Colors.white,
                    side: BorderSide(
                      color: _selectedValue == 'woman'
                          ? Color(0xFFE94158)
                          : Color(0xFFC3C0C7),
                    ),
                    foregroundColor: Color(0xFFe94057),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Woman',
                        style: TextStyle(
                          fontSize: 18,
                          color: _selectedValue == 'woman'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        FontAwesome.check_solid,
                        color: _selectedValue == 'woman'
                            ? Colors.white
                            : Color(0xFFADAFBB),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = 'man';
                      hasError = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    backgroundColor: _selectedValue == 'man'
                        ? Color(0xFFE94158)
                        : Colors.white,
                    side: BorderSide(
                      color: _selectedValue == 'man'
                          ? Color(0xFFE94158)
                          : Color(0xFFC3C0C7),
                    ),
                    foregroundColor: Color(0xFFe94057),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Man',
                        style: TextStyle(
                          fontSize: 18,
                          color: _selectedValue == 'man'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        FontAwesome.check_solid,
                        color: _selectedValue == 'man'
                            ? Colors.white
                            : Color(0xFFADAFBB),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedValue = 'other';
                      hasError = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    backgroundColor: _selectedValue == 'other'
                        ? Color(0xFFE94158)
                        : Colors.white,
                    side: BorderSide(
                      color: _selectedValue == 'other'
                          ? Color(0xFFE94158)
                          : Color(0xFFC3C0C7),
                    ),
                    foregroundColor: Color(0xFFe94057),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Everyone',
                        style: TextStyle(
                          fontSize: 18,
                          color: _selectedValue == 'other'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        FontAwesome.check_solid,
                        color: _selectedValue == 'other'
                            ? Colors.white
                            : Color(0xFFADAFBB),
                      )
                    ],
                  ),
                ),
                hasError
                    ? Container(
                        margin: EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text(
                          "Please select your gender preference.",
                          style: TextStyle(
                            color: Color(0xFFE94158),
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Age Range",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      'Between ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${preferenceAgeMin.toStringAsFixed(0)} & ${preferenceAgeMax.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFE94158),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                RangeSlider(
                  min: 18.0,
                  max: 60.0,
                  values: RangeValues(preferenceAgeMin, preferenceAgeMax),
                  activeColor: Color(0xFFE94158),
                  onChanged: (values) {
                    if (values.end - values.start >= 4) {
                      setState(() {
                        preferenceAgeMin = values.start;
                        preferenceAgeMax = values.end;
                      });
                    }
                  },
                )
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
                onPressed: () {
                  if (_selectedValue.isEmpty) {
                    setState(() {
                      hasError = true;
                    });
                  } else {
                    userProvider.updateUser(userProvider.user!.copyWith(
                      preferenceGender: _selectedValue,
                      preferenceAgeMin: preferenceAgeMin.toInt(),
                      preferenceAgeMax: preferenceAgeMax.toInt(),
                    ));
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SetProfilePictureScreen(),
                      ),
                    );
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
            ),
          ],
        ),
      ),
    );
  }
}
