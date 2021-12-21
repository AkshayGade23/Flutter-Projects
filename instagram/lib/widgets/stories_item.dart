import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String userName;
  StoryItem({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(userName),
        ],
      ),
    );
  }
}
