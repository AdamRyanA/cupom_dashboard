import 'package:cupom_dashboard/data/models/address.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:latlong2/latlong.dart';

class MapsStrings {

  static String addressFormattedAll(Address? text) {
    String result = "Estrada desconhecida";
    if (text != null) {
      if (text.addressLine1 != null) {
        result = "${text.addressLine1}";
      }else{
        result = "${text.addressLine2}";
      }
    }
    return result;
  }

  static LatLng? geometryToLatLnt(Geometry? geometry) {
    LatLng? latLng;
    if (geometry != null) {
      latLng = LatLng(double.tryParse("${geometry.location.lat}") ?? 0, double.tryParse("${geometry.location.lng}") ?? 0);
    }
    return latLng;
  }


  static Address toAddressMap(List<AddressComponent> addressComponents) {

    Address addressCustom = Address.toNull();

    for (AddressComponent addressComponent in addressComponents) {
      for (String type in addressComponent.types) {
        switch (type) {
          case 'street_number':
            addressCustom.number = addressComponent.longName;
            break;
          case 'route':
            addressCustom.street = addressComponent.longName;
            break;
          case 'sublocality':
            addressCustom.district = addressComponent.longName;
            break;
          case 'administrative_area_level_2':
            print(addressComponent.longName);
            addressCustom.city = addressComponent.longName;
            break;
          case 'administrative_area_level_1':
            print(addressComponent.longName);
            if (addressComponent.longName == "State of Paraná") {
              addressCustom.state = "Paraná";
            }else{
              addressCustom.state = addressComponent.longName;
            }
            break;
          case 'country':
            addressCustom.country = addressComponent.longName;
            break;
          case 'postal_code':
            addressCustom.postalCode = addressComponent.longName;
            break;
        }
      }
    }

    return addressCustom;
  }

  //static MapModel placesSearchtoMapModel(PlacesSearchResult placesSearchResult, PlacesDetailsResponse placesDetailsResponse) {
  static Address placesSearchtoMapModel(PlaceDetails placesSearchResult) {

    Address mapModel = MapsStrings.toAddressMap(placesSearchResult.addressComponents);;
    mapModel.addressLine1 = placesSearchResult.formattedAddress;
    mapModel.addressLine2 = placesSearchResult.formattedAddress;
    mapModel.placeId = placesSearchResult.placeId;
    mapModel.coordinates = MapsStrings.geometryToLatLnt(placesSearchResult.geometry);
    return mapModel;
  }



}