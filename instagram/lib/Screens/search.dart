import 'package:flutter/material.dart';
import 'package:instagram/widgets/explore_grid.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
                Container(
                  child: Text(
                    "search",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ExploreeGrid(),
    );
  }
}
