class ObjectIdMongo {
  String objectId;

  ObjectIdMongo(this.objectId);

  factory ObjectIdMongo.fromJson(dynamic json) {
    return ObjectIdMongo(json["\$oid"] as String);
  }

  @override
  String toString() {
    return objectId;
  }

}