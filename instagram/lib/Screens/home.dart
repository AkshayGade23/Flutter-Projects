import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/widgets/Post_item.dart';
import 'package:instagram/widgets/stories_item.dart';

class Home extends StatelessWidget {
  List<String> people = [
    "Akshay",
    "Vijay",
    "PranavRaj",
    "Vinay",
    "Sourabh",
    "Tushar",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Instagram",
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          //STORIES
          Container(
            padding: EdgeInsets.only(left: 5),
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: people.length,
              itemBuilder: (ctx, index) {
                return StoryItem(userName: people[index]);
              },
            ),
          ),
          // Posts

          Expanded(
            child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (ctx, index) {
                  return PostItem(userName: people[index]);
                }),
          ),
        ],
      ),
    );
  }
}
