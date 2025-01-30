import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController = TextEditingController();
  bool hasNameError = false;

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void handleSubmit() {
    bool isInvalidName = nameController.text.isEmpty;
    if (isInvalidName) {
      setState(() {
        hasNameError = true;
      });
    } else {
      setState(() {
        hasNameError = false;
      });
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
                    value: 11 / 100,
                    color: Color(0xFFe94158),
                    backgroundColor: Color(0xFFE3E5E5),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "What's your name?",
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
                    controller: nameController,
                    placeholder: "Enter your name",
                    placeholderStyle: TextStyle(
                      color: Color(0xFF090A0A),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.all(
                      16,
                    ),
                    onChanged: (value) {
                      if (hasNameError) {
                        setState(() {
                          hasNameError = false;
                        });
                      }
                    },
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
                  hasNameError
                      ? Text(
                          "Please enter your name",
                          style: TextStyle(
                            color: Color(0xFFE94158),
                            fontSize: 14,
                          ),
                        )
                      : Text(
                          "This is what'll appear on your profile.",
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
                  child: Text(
                    'Send Verification Code',
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
