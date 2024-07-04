import 'package:cupom_dashboard/data/models/categorys.dart';

import '../helpers/date_mongo.dart';
import '../helpers/object_id.dart';
import 'address.dart';

class Company{

  String? id;
  String? uid;
  String? email;
  String? phone;
  String? photo;
  String? name;
  String? docNumber;
  Categorys? category;
  bool? signature;
  String? customer;
  Address? address;
  String? subscriptionId;
  bool? enabled;
  String? created;
  String? updated;



  Company(
      this.id,
      this.uid,
      this.email,
      this.phone,
      this.photo,
      this.name,
      this.docNumber,
      this.category,
      this.signature,
      this.customer,
      this.address,
      this.subscriptionId,
      this.enabled,
      this.created,
      this.updated,
      );

  factory Company.fromJson(dynamic json) {


    var jsonId = json['_id'] as Map<String, dynamic>?;
    String? id;
    if (jsonId != null) {
      String jsonResult = ObjectIdMongo.fromJson(jsonId).toString();
      id = jsonResult;
    }

    var jsonCategory = json['category'] as Map<String, dynamic>?;
    Categorys? category;
    if (jsonCategory != null) {
      Categorys categoryResult = Categorys.fromJson(jsonCategory);
      category = categoryResult;
    }

    var jsonAddress = json['address'] as Map<String, dynamic>?;
    Address? address;
    if (jsonAddress != null) {
      Address addressResult = Address.fromJson(jsonAddress);
      address = addressResult;
    }

    var jsonUpdated = json['updated'] as Map<String, dynamic>?;
    String? updated;
    if (jsonUpdated != null) {
      String jsonDate = DateMongo.fromJson(jsonUpdated).toString();
      updated = jsonDate;
    }

    var jsonCreated = json['created'] as Map<String, dynamic>?;
    String? created;
    if (jsonCreated != null) {
      String jsonDate = DateMongo.fromJson(jsonCreated).toString();
      created = jsonDate;
    }


    return Company(
        id,
        json["uid"],
        json["email"],
        json["phone"],
        json["photo"],
        json["name"],
        json["docNumber"],
        category,
        json["signature"],
        json["customer"],
        address,
        json["subscriptionId"],
        json["enabled"],
        created,
        updated
    );
  }

  factory Company.toNull(){
    return Company(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
  }

  @override
  String toString() {
    return '{id: $id, uid: $uid, email: $email, phone: $phone, photo: $photo, name: $name, docNumber: $docNumber, category: $category, signature: $signature, customer: $customer, address: $address, subscriptionId: $subscriptionId, enabled: $enabled, created: $created, updated: $updated}';
  }
}