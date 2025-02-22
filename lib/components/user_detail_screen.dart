import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      images = userProvider.user!.moodBoard!.images;
    });
  }

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
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            IconsaxOutline.arrow_left_2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconsaxOutline.setting_2,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            NetworkImage(userProvider.user!.profileImageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFE94057),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        EvaIcons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                'Basic details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            _buildDetailItem('Name', userProvider.user!.name!, () {}),
            _buildDetailItem(
                'Gender',
                userProvider.user!.gender! == 'woman' ? 'Female' : 'Male',
                () {}),
            _buildDetailItem('Pronouns', 'Add', () {}),
            _buildDetailItem('Work', 'Add', () {}),
            _buildDetailItem('College', 'Add', () {}),
            _buildDetailItem('Hometown', 'Add', () {}),
            _buildDetailItem('Dating goal', 'Add', () {}),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                'More about me',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            _buildDetailItem('Religious beliefs', 'Add', () {}),
            _buildDetailItem('Height', 'Add', () {}),
            _buildDetailItem('Drinking', 'Add', () {}),
            _buildDetailItem('Smoking', 'Add', () {}),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                'My MoodBoard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ReorderableWrap(
              onReorder: (oldIndex, newIndex) => _onReorder(oldIndex, newIndex),
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
                    child: Container(
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
            const SizedBox(
              height: 64,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    String title,
    String value,
    VoidCallback onTap,
  ) {
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
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
                  color: Color(0xFFE94057),
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
