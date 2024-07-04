
import 'package:latlong2/latlong.dart';

import '../helpers/GeoPointMongoDB.dart';

class Address {
  String? street;
  String? number;
  String? district;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? addressLine1;
  String? addressLine2;
  String? placeId;
  LatLng? coordinates;

  Address(
      this.street,
      this.number,
      this.district,
      this.city,
      this.state,
      this.postalCode,
      this.country,
      this.addressLine1,
      this.addressLine2,
      this.placeId,
      this.coordinates,
      );

  factory Address.fromJson(dynamic json) {

    var jsonCoordinates = json['coordinates'] as Map<String, dynamic>?;
    LatLng? coordinates;
    if (jsonCoordinates != null) {
      GeoPointMongoDB coordinatesResult = GeoPointMongoDB.fromJson(jsonCoordinates);
      coordinates = coordinatesResult.coordinates;
    }


    return Address(
      json["street"],
      json["number"],
      json["district"],
      json["city"],
      json["state"],
      json["postalCode"],
      json["country"],
      json["addressLine1"],
      json["addressLine2"],
      json["placeId"],
      coordinates,
    );
  }

  factory Address.toNull() {
    return Address(null, null, null, null, null, null, null, null, null, null, null);
  }

  @override
  String toString() {
    return '{street: $street, number: $number, district: $district, city: $city, state: $state, postalCode: $postalCode, country: $country, addressLine1: $addressLine1, addressLine2: $addressLine2, placeId: $placeId, coordinates: $coordinates}';
  }
}