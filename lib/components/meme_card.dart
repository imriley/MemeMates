import 'package:flutter/material.dart';
import 'package:mememates/models/Meme.dart';

class MemeCard extends StatelessWidget {
  Meme meme;
  MemeCard({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.grey,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(meme.url),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
