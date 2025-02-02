import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateMoodBoard extends StatefulWidget {
  const CreateMoodBoard({super.key});

  @override
  State<CreateMoodBoard> createState() => _CreateMoodBoardState();
}

class _CreateMoodBoardState extends State<CreateMoodBoard> {
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
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Column(children: [Column(children: [SizedBox(height: 16,),LinearProgressIndicator(value: 88/100, color: Color(0xFFe94158),backgroundColor: Color(0xFFE3E5E5),),SizedBox(height: 32,),Text("Let’s create your Mood Board, upload your favorite memes or your pictures",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),SizedBox(height: 16,),Text('Hold and drag to reorder your photos', style: TextStyle(color: Color(0xFF7D7D7D), fontSize: 14),)],)],)),
    );
  }
}
