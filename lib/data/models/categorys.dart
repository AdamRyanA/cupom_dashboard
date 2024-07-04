import '../helpers/date_mongo.dart';
import '../helpers/object_id.dart';

class Categorys {
  String? id;
  String? category;
  String? created;
  String? updated;

  Categorys(
      this.id,
      this.category,
      this.created,
      this.updated
      );

  factory Categorys.fromJson(dynamic json) {

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


    return Categorys(
        id,
        json["category"],
        created,
        updated
    );
  }

  factory Categorys.toNull() {
    return Categorys(null, null, null, null);
  }

  @override
  String toString() {
    return 'Categorys{id: $id, category: $category, created: $created, updated: $updated}';
  }
}