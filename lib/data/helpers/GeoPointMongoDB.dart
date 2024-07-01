import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoPointMongoDB {
  LatLng? coordinates;

  GeoPointMongoDB(this.coordinates);

  factory GeoPointMongoDB.fromJson(dynamic json) {
    print(json);
    List mapCoordinates = json['coordinates'] as List<dynamic>;
    LatLng? coordinatesLatLng;
    double latitude = mapCoordinates[0];
    double longitude = mapCoordinates[1];
    coordinatesLatLng = LatLng(latitude, longitude);


    return GeoPointMongoDB(
        coordinatesLatLng
    );
  }

  @override
  String toString() {
    return "$coordinates";
  }

}