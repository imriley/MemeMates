import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SetProfilePictureScreen extends StatefulWidget {
  const SetProfilePictureScreen({super.key});

  @override
  State<SetProfilePictureScreen> createState() =>
      _SetProfilePictureScreenState();
}

class _SetProfilePictureScreenState extends State<SetProfilePictureScreen> {
  File? selectedImage;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      final croppedImage = await _cropImage(imageTemp);
      setState(() {
        selectedImage = croppedImage;
      });
    } catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    try {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 100,
        maxHeight: 400,
      );
      if (croppedImage == null) return null;
      return File(croppedImage.path);
    } catch (e) {
      print('Failed to crop image: $e');
    }
    return null;
  }

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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            IconsaxOutline.arrow_left_2,
          ),
        ),
        actions: [
          CupertinoButton(
            child: Text(
              'Skip'.toUpperCase(),
              style: TextStyle(
                color: Color(0xFF7D7D7D),
              ),
            ),
            onPressed: () {},
          )
        ],
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
                  value: 77 / 100,
                  color: Color(0xFFe94158),
                  backgroundColor: Color(0xFFE3E5E5),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Let's add your profile picture",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: selectedImage != null
                      ? Stack(
                          children: [
                            Container(
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: FileImage(selectedImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFe94158),
                                ),
                                child: Icon(
                                  EvaIcons.edit,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            )
                          ],
                        )
                      : DottedBorder(
                          radius: Radius.circular(16),
                          color: Color(0xFFe94158),
                          strokeWidth: 2,
                          dashPattern: [10, 10],
                          borderType: BorderType.RRect,
                          child: SizedBox(
                            height: 400,
                            child: Center(
                              child: Icon(
                                Iconsax.add_circle_bold,
                                color: Color(0xFFe94158),
                                size: 80,
                              ),
                            ),
                          ),
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
    );
  }
}
