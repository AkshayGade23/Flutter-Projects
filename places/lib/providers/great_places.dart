import 'dart:io';

import 'package:flutter/foundation.dart';
import '../helpers/location_helper.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(
    String pickedtitle,
    File pickedimage,
    PlaceLocation pickedlocation,
  ) async {
    final pickedaddress = await LocationHelper.getPlaceAddress(
        pickedlocation.latitude, pickedlocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedlocation.latitude,
        longitude: pickedlocation.longitude,
        address: pickedaddress);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedtitle,
      location: updatedLocation,
      image: pickedimage,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    print('start');
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'],
              ),
              image: File(item['image']),
            ))
        .toList();
    notifyListeners();
    print('end');
  }
}
