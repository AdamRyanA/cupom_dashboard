import 'package:cupom_dashboard/data/models/categorys.dart';
import 'package:cupom_dashboard/data/models/type_offer.dart';
import 'package:flutter_google_maps_webservices/places.dart';

import 'citys.dart';
import 'company.dart';
import 'offer.dart';
import 'subscription.dart';
import 'user_client.dart';


class ResponseAPI {
  String? message;
  UserClient? user;
  List<UserClient>? users;
  Subscription? subscription;
  List<Subscription>? subscriptions;
  Citys? city;
  List<Citys>? citys;
  Company? company;
  List<Company>? companys;
  Categorys? category;
  List<Categorys>? categorys;
  List<Prediction>? predictions;
  TypeOffer? typeOffer;
  List<TypeOffer>? typeOffers;
  Offer? offer;
  List<Offer>? offers;

  ResponseAPI(
      this.message,
      this.user,
      this.users,
      this.subscription,
      this.subscriptions,
      this.city,
      this.citys,
      this.company,
      this.companys,
      this.category,
      this.categorys,
      this.predictions,
      this.typeOffer,
      this.typeOffers,
      this.offer,
      this.offers
      );

  factory ResponseAPI.fromJson(dynamic json) {


    var jsonUser = json['user'] as Map<String, dynamic>?;
    UserClient? userClient;
    if (jsonUser != null) {
      UserClient userClientResult = UserClient.fromJson(jsonUser);
      userClient = userClientResult;
    }

    var jsonUsers = json['users'] as List<dynamic>?;
    List<UserClient>? users;
    if (jsonUsers != null) {
      users = [];
      for (var element in jsonUsers) {
        var elementMap = element as Map<String, dynamic>?;
        UserClient userClientsResult = UserClient.fromJson(elementMap);
        users.add(userClientsResult);
      }
    }

    var jsonSubscription = json['subscription'] as Map<String, dynamic>?;
    Subscription? subscription;
    if (jsonSubscription != null) {
      Subscription subscriptionResult = Subscription.fromJson(jsonSubscription);
      subscription = subscriptionResult;
    }

    var jsonSubscriptions = json['subscriptions'] as List<dynamic>?;
    List<Subscription>? subscriptions;
    if (jsonSubscriptions != null) {
      subscriptions = [];
      for (var element in jsonSubscriptions) {
        var elementMap = element as Map<String, dynamic>?;
        Subscription subscriptionResult = Subscription.fromJson(elementMap);
        subscriptions.add(subscriptionResult);
      }
    }

    var jsonCity = json['city'] as Map<String, dynamic>?;
    Citys? city;
    if (jsonCity != null) {
      Citys cityResult = Citys.fromJson(jsonCity);
      city = cityResult;
    }

    var jsonCitys = json['citys'] as List<dynamic>?;
    List<Citys>? citys;
    if (jsonCitys != null) {
      citys = [];
      for (var element in jsonCitys) {
        var elementMap = element as Map<String, dynamic>?;
        Citys citysResult = Citys.fromJson(elementMap);
        citys.add(citysResult);
      }
    }

    var jsonCompany = json['company'] as Map<String, dynamic>?;
    Company? company;
    if (jsonCompany != null) {
      Company companyResult = Company.fromJson(jsonCompany);
      company = companyResult;
    }

    var jsonCompanys = json['companys'] as List<dynamic>?;
    List<Company>? companys;
    if (jsonCompanys != null) {
      companys = [];
      for (var element in jsonCompanys) {
        var elementMap = element as Map<String, dynamic>?;
        Company companysResult = Company.fromJson(elementMap);
        companys.add(companysResult);
      }
    }

    var jsonCategory = json['category'] as Map<String, dynamic>?;
    Categorys? category;
    if (jsonCategory != null) {
      Categorys categoryResult = Categorys.fromJson(jsonCategory);
      category = categoryResult;
    }

    var jsonCategorys = json['categorys'] as List<dynamic>?;
    List<Categorys>? categorys;
    if (jsonCategorys != null) {
      categorys = [];
      for (var element in jsonCategorys) {
        var elementMap = element as Map<String, dynamic>?;
        Categorys categorysResult = Categorys.fromJson(elementMap);
        categorys.add(categorysResult);
      }
    }

    var jsonPredictions = json['predictions'] as List<dynamic>?;
    List<Prediction>? predictions;
    if (jsonPredictions != null) {
      predictions = [];
      for (var element in jsonPredictions) {
        if (element != null) {
          var elementMap = element as Map<String, dynamic>;
          Prediction predictionsResult = Prediction.fromJson(elementMap);
          predictions.add(predictionsResult);
        }
      }
      predictions.removeWhere((element) => element.placeId == null);
    }

    var jsonTypeOffer = json['type_offer'] as List<dynamic>?;
    TypeOffer? typeOffer;
    if (jsonTypeOffer != null) {
      TypeOffer typeOfferResult = TypeOffer.fromJson(jsonTypeOffer);
      typeOffer = typeOfferResult;
    }

    var jsonTypeOffers = json['type_offers'] as List<dynamic>?;
    List<TypeOffer>? typeOffers;
    if (jsonTypeOffers != null) {
      typeOffers = [];
      for (var element in jsonTypeOffers) {
        if (element != null) {
          var elementMap = element as Map<String, dynamic>;
          TypeOffer typeOffersResult = TypeOffer.fromJson(elementMap);
          typeOffers.add(typeOffersResult);
        }
      }
    }

    var jsonOffer = json['offer'] as Map<String, dynamic>?;
    Offer? offer;
    if (jsonOffer != null) {
      Offer offerResult = Offer.fromJson(jsonOffer);
      offer = offerResult;
    }

    var jsonOffers = json['offers'] as List<dynamic>?;
    List<Offer>? offers;
    if (jsonOffers != null) {
      offers = [];
      for (var element in jsonOffers) {
        if (element != null) {
          var elementMap = element as Map<String, dynamic>;
          Offer offersResult = Offer.fromJson(elementMap);
          offers.add(offersResult);
        }
      }
    }

    return ResponseAPI(
        json["message"],
        userClient,
        users,
        subscription,
        subscriptions,
        city,
        citys,
        company,
        companys,
        category,
        categorys,
        predictions,
        typeOffer,
        typeOffers,
        offer,
        offers
    );
  }

  factory ResponseAPI.toNull() {
    return ResponseAPI(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
  }

  @override
  String toString() {
    return '{message: $message, user: $user, users: $users, subscription: $subscription, subscriptions: $subscriptions, city: $city, citys: $citys, company: $company, companys: $companys, category: $category, categorys: $categorys, predictions: $predictions, typeOffer: $typeOffer, typeOffers: $typeOffers, offer: $offer, offers: $offers}';
  }
}