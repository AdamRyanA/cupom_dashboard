import '../helpers/date_mongo.dart';
import '../helpers/object_id.dart';

class UserClient{

  String? id;
  String? uid;
  String? email;
  String? phone;
  String? photo;
  String? displayName;
  bool? signature;
  String? customer;
  String? subscriptionId;
  String? created;
  String? updated;



   UserClient(
       this.id,
       this.uid,
       this.email,
       this.phone,
       this.photo,
       this.displayName,
       this.signature,
       this.customer,
       this.subscriptionId,
       this.created,
       this.updated,
       );

   factory UserClient.fromJson(dynamic json) {


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


     return UserClient(
         id,
         json["uid"],
         json["email"],
         json["phone"],
         json["photo"],
         json["displayName"],
         json["signature"],
         json["customer"],
         json["subscriptionId"],
         created,
         updated
     );
   }

   factory UserClient.toNull(){
     return UserClient(null, null, null, null, null, null, null, null, null, null, null);
   }

  @override
  String toString() {
    return '{id: $id, uid: $uid, email: $email, phone: $phone, photo: $photo, displayName: $displayName, signature: $signature, customer: $customer, subscriptionId: $subscriptionId, created: $created, updated: $updated}';
  }
}