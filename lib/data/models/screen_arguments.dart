import 'address.dart';
import 'company.dart';
import 'offer.dart';
import 'restaurant.dart';
import 'subscription.dart';
import 'type_offer.dart';
import 'user_client.dart';

class ScreenArguments {
  Restaurant? restaurant;
  UserClient? userClient;
  Subscription? subscription;
  Company? company;
  Address? address;
  TypeOffer? typeOffers;
  Offer? offer;

  ScreenArguments();
}