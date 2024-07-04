import 'package:cupom_dashboard/data/models/address.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import "package:flutter_google_maps_webservices/geocoding.dart";

import '../../data/helpers/maps_string.dart';


class MapsProcess {

  static String getGoogleApiKey() {
    String apiKey = "AIzaSyBAF74GwRazqPloEBaojxQVo5GlkrOt7Ls";
    return apiKey;
  }

  //Reverse GeoCoding sample call
  static Future<Address> geoCodingGoogleOne(double lat, double long) async {
    String apiKey = getGoogleApiKey();
    final geocoding = GoogleMapsGeocoding(apiKey: apiKey);
    GeocodingResponse response = await geocoding.searchByLocation(
        Location(lat: lat, lng: long),
        language: "pt-BR"
    );
    GeocodingResult geocodingResult = response.results.first;
    Address addressCustom = MapsStrings.toAddressMap(geocodingResult.addressComponents);
    addressCustom.placeId = geocodingResult.placeId;
    addressCustom.coordinates = MapsStrings.geometryToLatLnt(geocodingResult.geometry);

    return addressCustom;
  }

  static Future<Address?> geoCodingGoogleOneResult(Prediction mapBoxPlace) async {
    Address? address;

    String apiKey = getGoogleApiKey();
    final geocoding = GoogleMapsGeocoding(apiKey: apiKey);
    GeocodingResponse response = await geocoding.searchByPlaceId(
        "${mapBoxPlace.placeId}",
        language: "pt-BR"
    );
    GeocodingResult geocodingResult = response.results.first;
    address = MapsStrings.toAddressMap(geocodingResult.addressComponents);
    address.placeId = mapBoxPlace.placeId;
    address.coordinates = MapsStrings.geometryToLatLnt(geocodingResult.geometry);

    return address;
  }

  static Future<List<Prediction>> googleMapsPlaceSearch(String text, Location? location, String sessionToken) async {
    String apiKey = getGoogleApiKey();
    final places = GoogleMapsPlaces(
        apiKey: apiKey,
    );
    //print(places.url);
    /*
    PlacesSearchResponse response = await places.searchByText(
      text,
      language: "pt-BR",
      location: location,
      //pagetoken: sessionToken
    );
    */
    /*
    PlacesAutocompleteResponse response = await places.autocomplete(
      text,
      language: "pt-BR",
      origin: location,
      location: location,
      sessionToken: sessionToken,
      radius: 100
      //pagetoken: sessionToken
    );
     */

    PlacesAutocompleteResponse response = await places.queryAutocomplete(
        text,
        language: "pt-BR",
        location: location,
        radius: 100
      //pagetoken: sessionToken
    );
    //print(response.predictions.first.placeId);

    List<Prediction> predictionsResult = response.predictions;
    predictionsResult.removeWhere((element) => element.placeId == null);
    return predictionsResult;
    //return response.results;
  }

  ///CUSTO MUITO ALTO

  /*
  static Future<PlaceDetails> placeDetailsResponseById(String placeId) async {
    String apiKey = getGoogleApiKey();
    final places = GoogleMapsPlaces(apiKey: apiKey);
    PlacesDetailsResponse response = await places.getDetailsByPlaceId(
        placeId,
      language: "pt-BR",
    );
    return response.result;
  }
   */

  /*
  LatLngBounds calculateBounds(List<LatLng> coordinates) {

    double minLat = double.infinity;
    double minLng = double.infinity;
    double maxLat = double.negativeInfinity;
    double maxLng = double.negativeInfinity;

    for (LatLng coordinate in coordinates) {
      minLat = min(minLat, coordinate.latitude);
      minLng = min(minLng, coordinate.longitude);
      maxLat = max(maxLat, coordinate.latitude);
      maxLng = max(maxLng, coordinate.longitude);
    }

    return LatLngBounds(
      northeast: LatLng(maxLat, maxLng),
      southwest: LatLng(minLat, minLng),
    );
  }
   */



}