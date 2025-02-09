import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class FinalizeProfile extends StatefulWidget {
  const FinalizeProfile({super.key});

  @override
  State<FinalizeProfile> createState() => _FinalizeProfileState();
}

class _FinalizeProfileState extends State<FinalizeProfile> {
  bool isProcessing = false;
  List images = [
    'https://images8.alphacoders.com/123/1234928.jpg',
    'https://img.freepik.com/premium-photo/pink-anime-girl-with-pink-hair-is-standing-tree-with-sky-background_849715-21393.jpg',
    'https://img.freepik.com/premium-photo/anime-girl-with-pink-hair-white-shirt_839169-30075.jpg',
    'https://cdn.shopify.com/s/files/1/0287/9062/0212/files/1_5d077683-0c77-4c7c-b7f5-327b98d1c300_480x480.jpg?v=1649440077',
    'https://images.saymedia-content.com/.image/t_share/MTc2MjczMzQ2MDcyNjE4MTc0/15-badass-black-hair-anime-girls.jpg',
  ];
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
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
          onPressed: () async {},
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
                    value: 'Riley',
                    onTap: () {
                      // Handle name tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Gender',
                    value: 'Male',
                    onTap: () {
                      // Handle gender tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Date of Birth',
                    value: '01-01-2000',
                    onTap: () {
                      // Handle date of birth tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Age Range',
                    value: '20 - 24',
                    onTap: () {
                      // Handle age range tap
                    },
                  ),
                  _buildDetailItem(
                    context: context,
                    label: 'Gender Preference',
                    value: 'Female',
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
                                      image: NetworkImage(image),
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
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
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
