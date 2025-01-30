import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedValue;

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  value: 55 / 100,
                  color: Color(0xFFe94158),
                  backgroundColor: Color(0xFFE3E5E5),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "What's your gender?",
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
                        'Other',
                        style: TextStyle(
                          fontSize: 18,
                          color: _selectedValue == 'other'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Icon(
                        FontAwesome.angle_right_solid,
                        color: _selectedValue == 'other'
                            ? Colors.white
                            : Color(0xFFADAFBB),
                      )
                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}
