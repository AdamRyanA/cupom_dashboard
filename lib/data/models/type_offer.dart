import 'package:cupom_dashboard/data/models/categorys.dart';

import '../helpers/date_mongo.dart';
import '../helpers/object_id.dart';

class TypeOffer {
  String? id;
  Categorys? category;
  String? name;
  String? created;
  String? updated;


  TypeOffer(
      this.id,
      this.category,
      this.name,
      this.created,
      this.updated
      );

  factory TypeOffer.fromJson(dynamic json) {

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


    return TypeOffer(
        id,
        category,
        json["name"],
        created,
        updated
    );
  }

  factory TypeOffer.toNull() {
    return TypeOffer(null, null, null, null, null);
  }

  @override
  String toString() {
    return '{id: $id, category: $category, name: $name, created: $created, updated: $updated}';
  }
}