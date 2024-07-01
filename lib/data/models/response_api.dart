import 'citys.dart';
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

  ResponseAPI(
      this.message,
      this.user,
      this.users,
      this.subscription,
      this.subscriptions,
      this.city,
      this.citys
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

    return ResponseAPI(
        json["message"],
        userClient,
        users,
        subscription,
        subscriptions,
        city,
        citys
    );
  }

  factory ResponseAPI.toNull() {
    return ResponseAPI(null, null, null, null, null, null, null);
  }

  @override
  String toString() {
    return '{message: $message, user: $user, users: $users, subscription: $subscription, subscriptions: $subscriptions, city: $city, citys: $citys}';
  }
}