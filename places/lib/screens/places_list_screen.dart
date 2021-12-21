import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/screens/places_detail_screen.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                    child: Text('Got no places yet, start adding some!')),
                builder: (ctx, greatplaces, ch) => greatplaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatplaces.items.length,
                        itemBuilder: (ctx, i) => Container(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                greatplaces.items[i].image,
                              ),
                              radius: 23,
                            ),
                            title: Text(
                              greatplaces.items[i].title,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            subtitle:
                                Text(greatplaces.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatplaces.items[i].id);
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
