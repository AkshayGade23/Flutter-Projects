import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places/screens/map_screen.dart';
import '../models/http-error.dart';
import '../helpers/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;

  LocationInput(this.selectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewdImageUrl;
  bool cantToLoadImage = false;

  void _showPreview(double lat, double lng) {
    final staticMapImage = LocationHelper.generateLocationPreviewImage(
      lat,
      lng,
    );
    setState(() {
      _previewdImageUrl = staticMapImage;
      if (_previewdImageUrl == null) {
        cantToLoadImage = true;
      }
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      cantToLoadImage = false;
      _showPreview(locData.latitude, locData.longitude);
      widget.selectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewdImageUrl == null
              ? cantToLoadImage
                  ? Text(
                      'Unable to Load Image, Sorry!',
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'No Location Choosen',
                      textAlign: TextAlign.center,
                    )
              : Image.network(
                  _previewdImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Select On Map'),
            ),
          ],
        )
      ],
    );
  }
}
