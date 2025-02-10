import 'dart:io';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mememates/screens/main_screen.dart';
import 'package:mememates/utils/providers/userprovider.dart';
import 'package:mememates/utils/storage/firestore.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class FinalizeProfileScreen extends StatefulWidget {
  const FinalizeProfileScreen({super.key});

  @override
  State<FinalizeProfileScreen> createState() => _FinalizeProfileScreenState();
}

class _FinalizeProfileScreenState extends State<FinalizeProfileScreen> {
  bool isProcessing = false;
  late UserProvider userProvider;
  List images = [];
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex--;
      }
      final item = images.removeAt(oldIndex);
      images.insert(newIndex, item);
    });
  }

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    final profilePicturePath = userProvider.user!.profileImageUrl!;
    images.add(File(profilePicturePath));
    images.addAll(
      userProvider.user!.moodBoard!.images.map(
        (ele) => File(ele),
      ),
    );
  }

  void handleSubmit() async {
    setState(() {
      isProcessing = true;
    });
    try {
      final profilePictureUrl = await uploadProfilePicture(
        File(images[0].path),
      );
      List<String> imagesUrls = [];
      for (var i = 1; i < images.length; i++) {
        imagesUrls.add(
          await uploadMoodBoardImage(
            File(
              images[i].path,
            ),
          ),
        );
      }
      final user = userProvider.user!;
      user.profileImageUrl = profilePictureUrl;
      user.moodBoard!.images = imagesUrls;
      userProvider.updateUser(user);
      await addUser(userProvider.user!);

      setState(() {
        isProcessing = false;
      });
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        isProcessing = false;
      });
      print('Something went wrong: $e');
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
          icon: Icon(IconsaxOutline.arrow_left_2),
        ),
        centerTitle: true,
        title: Text(
          "Finalize Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      bottomSheet: Container(
        margin: EdgeInsets.only(
          bottom: 32,
        ),
        padding: EdgeInsets.symmetric(horizontal: 24),
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              const Text(
                'Basic details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem(
                    context: context,
                    label: 'Name',
                    value: userProvider.user!.name!,
                    onTap: () {
                      // Handle name tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Gender',
                    value:
                        userProvider.user!.gender! == "man" ? "Male" : "Female",
                    onTap: () {
                      // Handle gender tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Date of Birth',
                    value: DateFormat('MMM dd, yyyy')
                        .format(userProvider.user!.dateOfBirth!),
                    onTap: () {
                      // Handle date of birth tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Age Range',
                    value:
                        "${userProvider.user!.preferenceAgeMin} - ${userProvider.user!.preferenceAgeMax}",
                    onTap: () {
                      // Handle age range tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Gender Preference',
                    value: userProvider.user!.preferenceGender! == "man"
                        ? "Men"
                        : "Women",
                    onTap: () {
                      // Handle gender preference tap
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Your Photos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ReorderableWrap(
                onReorder: (oldIndex, newIndex) =>
                    _onReorder(oldIndex, newIndex),
                spacing: 16,
                runSpacing: 16,
                children: List.generate(images.length, (index) {
                  final image = images[index];
                  return ReorderableWidget(
                    key: ValueKey(image),
                    reorderable: true,
                    child: SizedBox(
                      height: 155,
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      child: index == 0
                          ? Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    image: DecorationImage(
                                      image: FileImage(image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                    margin: EdgeInsets.only(
                                      bottom: 4,
                                      left: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    child: Text(
                                      'Profile Picture',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: FileImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 92,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              16,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
