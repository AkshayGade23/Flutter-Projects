import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String userName;
  PostItem({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // post User
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[400]),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          // post picture
          Container(
            height: 400,
            color: Colors.grey,
          ),
          // post bottom ({like comment share  bookmark } Icons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.favorite)),
                  IconButton(onPressed: null, icon: Icon(Icons.comment)),
                  IconButton(onPressed: null, icon: Icon(Icons.share)),
                ],
              ),
              IconButton(onPressed: null, icon: Icon(Icons.bookmark)),
            ],
          ),
          // Liked by
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Row(
              children: [
                Text('Liked By '),
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(' and '),
                Text(
                  'others',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Comments
          Padding(
            padding: const EdgeInsets.only(left: 7, top: 5),
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: '$userName  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                        text:
                            ' hey, nice app keep doing it, you will be succesful in your life.')
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
