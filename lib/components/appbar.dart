import 'package:flutter/material.dart';
import 'package:mememates/models/User.dart';
import 'package:mememates/utils/providers/user_provider.dart';
import 'package:mememates/utils/storage/firestore.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const TopAppBar({super.key, required this.title});

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarState extends State<TopAppBar> {
  User currentUser = User();
  String profileImageUrl = '';
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final user = await getCurrentUser();
    setState(() {
      currentUser = user!;
      profileImageUrl = user.profileImageUrl!;
    });
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.updateUser(user!);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: profileImageUrl == ''
              ? CircleAvatar()
              : CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser.profileImageUrl!,
                  ),
                ),
        ),
        SizedBox(
          width: 24,
        ),
      ],
    );
  }
}
