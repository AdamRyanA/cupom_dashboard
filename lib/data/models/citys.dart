import '../helpers/date_mongo.dart';
import '../helpers/object_id.dart';

class Citys {
  String? id;
  String? city;
  String? state;
  String? created;
  String? updated;

  Citys(
      this.id,
      this.city,
      this.state,
      this.created,
      this.updated
      );

  factory Citys.fromJson(dynamic json) {

    var jsonId = json['_id'] as Map<String, dynamic>?;
    String? id;
    if (jsonId != null) {
      String jsonResult = ObjectIdMongo.fromJson(jsonId).toString();
      id = jsonResult;
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


    return Citys(
        id,
        json["city"],
        json["state"],
        created,
        updated
    );
  }

  factory Citys.toNull() {
    return Citys(null, null, null, null, null);
  }

  @override
  String toString() {
    return '{id: $id, city: $city, state: $state, created: $created, updated: $updated}';
  }
}