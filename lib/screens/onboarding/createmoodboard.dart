import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mememates/models/MoodBoard.dart';
import 'package:mememates/utils/providers/userprovider.dart';
import 'package:mememates/utils/storage/firestore.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class CreateMoodBoard extends StatefulWidget {
  const CreateMoodBoard({super.key});

  @override
  State<CreateMoodBoard> createState() => _CreateMoodBoardState();
}

class _CreateMoodBoardState extends State<CreateMoodBoard> {
  List<File?> selectedImages = [];
  int imagesLength = 4;
  bool hasError = false;
  bool isProcessing = false;

  void _onReorder(int oldIndex, int newIndex) {
    if (isProcessing) return;
    if (selectedImages.isEmpty || selectedImages.length < 2) return;

    setState(() {
      if (newIndex > oldIndex) {
        newIndex--;
      }
      final item = selectedImages.removeAt(oldIndex);
      selectedImages.insert(newIndex, item);
    });
  }

  void handleSubmit() async {
    setState(() {
      isProcessing = true;
    });
    if (selectedImages.isEmpty || selectedImages.length < imagesLength) {
      setState(() {
        hasError = true;
      });
    }
    List<String> imagesLinks = [];
    for (var image in selectedImages) {
      final downloadUrl = await uploadMoodBoardImage(image!);
      imagesLinks.add(downloadUrl);
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUser(userProvider.user!.copyWith(
      moodBoard: MoodBoard(images: imagesLinks),
    ));
    setState(() {
      isProcessing = false;
    });
  }

  Future pickImage(int index) async {
    try {
      setState(() {
        hasError = false;
      });
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      final croppedImage = await _cropImage(imageTemp);
      if (selectedImages.isEmpty) {
        setState(() {
          selectedImages.add(croppedImage);
        });
      } else {
        if (selectedImages.length < imagesLength) {
          setState(() {
            selectedImages.add(croppedImage);
          });
        } else {
          setState(() {
            selectedImages[index] = croppedImage;
          });
        }
      }
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
        padding: EdgeInsets.symmetric(horizontal: 24),
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
                  value: 88 / 100,
                  color: Color(0xFFe94158),
                  backgroundColor: Color(0xFFE3E5E5),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Let's create your Mood Board, upload your favorite memes or your pictures",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Hold and drag to reorder your photos',
                  style: TextStyle(
                    color: Color(0xFF7D7D7D),
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                ReorderableWrap(
                  onReorder: (int oldIndex, int newIndex) =>
                      _onReorder(oldIndex, newIndex),
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    imagesLength,
                    (index) {
                      final selectedImage = selectedImages.isEmpty
                          ? null
                          : selectedImages.length > index
                              ? selectedImages[index]
                              : null;

                      return ReorderableWidget(
                        key: ValueKey(index),
                        reorderable: true,
                        child: GestureDetector(
                          onTap: isProcessing ? null : () => pickImage(index),
                          child: selectedImage != null
                              ? SizedBox(
                                  height: 155,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      32,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(selectedImage),
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
                                  ),
                                )
                              : DottedBorder(
                                  radius: Radius.circular(16),
                                  color: Color(0xFFe94158),
                                  strokeWidth: 2,
                                  dashPattern: [10, 10],
                                  borderType: BorderType.RRect,
                                  child: SizedBox(
                                    height: 155,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            36,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.add_circle_bold,
                                        color: Color(0xFFe94158),
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                hasError
                    ? Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Text(
                          'You need at least 4 pictures to proceed.',
                          style: TextStyle(
                            color: Color(0xFFE94158),
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 32,
              ),
              child: TextButton(
                onPressed: isProcessing ? null : handleSubmit,
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
            )
          ],
        ),
      ),
    );
  }
}
