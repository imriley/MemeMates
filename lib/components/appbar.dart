import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mememates/components/user_detail_screen.dart';
import 'package:mememates/models/User.dart';
import 'package:mememates/utils/providers/user_provider.dart';
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
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      currentUser = userProvider.user!;
      profileImageUrl = currentUser.profileImageUrl!;
    });
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
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => UserDetailScreen(),
              ),
            );
          },
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
