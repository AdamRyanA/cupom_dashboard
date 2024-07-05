import 'package:cupom_dashboard/data/models/address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import "package:flutter_google_maps_webservices/geocoding.dart";

import '../../data/helpers/dio_helper.dart';
import '../../data/helpers/maps_string.dart';
import '../../data/models/response_api.dart';
import '../../data/utils/base_url.dart';
import 'Authentication.dart';


class MapsProcess {

  static Future<ResponseAPI?> post({
    required String inputText,
  }) async {
    FirebaseAuth user = Authentication.auth;
    String? uid = user.currentUser?.uid;

    if (uid != null) {
      String url = ApiCupomRatata.autocomplete;
      if (kDebugMode) {
        print(url);
      }
      Map<String, dynamic> data = {
        "input_text": inputText,
      };
      ResponseAPI? responseResult = await DioHelper.post(url: url, data: data);
      return responseResult;
    }else{
      if (kDebugMode) {
        print("No user uid");
      }
      return null;
    }
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

  static String getGoogleApiKey() {
    String apiKey = "AIzaSyBAF74GwRazqPloEBaojxQVo5GlkrOt7Ls";
    return apiKey;
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
    address.addressLine1 = mapBoxPlace.description;
    address.addressLine2 = mapBoxPlace.structuredFormatting?.secondaryText;

    return address;
  }

  static Future<List<Prediction>> googleMapsPlaceSearch(String text, Location? location, String sessionToken) async {
    //String apiKey = getGoogleApiKey();
    List<Prediction> predictionsResult = [];
    /*
    final places = GoogleMapsPlaces(
        apiKey: apiKey,
    );

    PlacesAutocompleteResponse response = await places.queryAutocomplete(
        text,
        language: "pt-BR",
        location: location,
        radius: 100
      //pagetoken: sessionToken
    );
    if (kDebugMode) {
      print(response.predictions.first.placeId);
    }
     */
    ResponseAPI? responseResult = await post(inputText: text);
    if (responseResult != null) {
      predictionsResult = responseResult.predictions ?? [];
      predictionsResult.removeWhere((element) => element.placeId == null);
    }
    return predictionsResult;
    //return response.results;
  }



}