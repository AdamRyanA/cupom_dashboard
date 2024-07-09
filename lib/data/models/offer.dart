import 'package:cupom_dashboard/data/helpers/time_range_convert.dart';
import 'package:cupom_dashboard/data/models/categorys.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../helpers/date_mongo.dart';
import '../helpers/object_id.dart';
import 'company.dart';
import 'type_offer.dart';

class Offer {
  String? id;
  Company? company;
  String? name;
  Categorys? category;
  String? categoryOffer;
  String? descriptionOffer;
  String? photo;
  TypeOffer? typeOffer;
  TimeRange? monday;
  TimeRange? tuesday;
  TimeRange? wednesday;
  TimeRange? thursday;
  TimeRange? friday;
  TimeRange? saturday;
  TimeRange? sunday;
  String? created;
  String? updated;


  Offer(
      this.id,
      this.company,
      this.name,
      this.category,
      this.categoryOffer,
      this.descriptionOffer,
      this.photo,
      this.typeOffer,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday,
      this.created,
      this.updated
      );

  factory Offer.fromJson(dynamic json) {

    var jsonId = json['_id'] as Map<String, dynamic>?;
    String? id;
    if (jsonId != null) {
      String jsonResult = ObjectIdMongo.fromJson(jsonId).toString();
      id = jsonResult;
    }

    var jsonCompany = json['company'] as Map<String, dynamic>?;
    Company? company;
    if (jsonCompany != null) {
      Company companyResult = Company.fromJson(jsonCompany);
      company = companyResult;
    }

    var jsonCategory = json['category'] as Map<String, dynamic>?;
    Categorys? category;
    if (jsonCategory != null) {
      Categorys categoryResult = Categorys.fromJson(jsonCategory);
      category = categoryResult;
    }

    var jsonTypeOffer = json['typeOffer'] as Map<String, dynamic>?;
    TypeOffer? typeOffer;
    if (jsonTypeOffer != null) {
      TypeOffer typeOfferResult = TypeOffer.fromJson(jsonTypeOffer);
      typeOffer = typeOfferResult;
    }


    var jsonMondayStart = json['mondayStart'] as String?;
    var jsonMondayEnd = json['mondayEnd'] as String?;
    TimeRange? monday;
    if (jsonMondayStart != null && jsonMondayEnd != null) {
      monday = convertTimeRange(jsonMondayStart, jsonMondayEnd);
    }

    var jsonTuesdayStart = json['tuesdayStart'] as String?;
    var jsonTuesdayEnd = json['tuesdayEnd'] as String?;
    TimeRange? tuesday;
    if (jsonTuesdayStart != null && jsonTuesdayEnd != null) {
      tuesday = convertTimeRange(jsonTuesdayStart, jsonTuesdayEnd);
    }

    var jsonWednesdayStart = json['wednesdayStart'] as String?;
    var jsonWednesdayEnd = json['wednesdayEnd'] as String?;
    TimeRange? wednesday;
    if (jsonWednesdayStart != null && jsonWednesdayEnd != null) {
      wednesday = convertTimeRange(jsonWednesdayStart, jsonWednesdayEnd);
    }

    var jsonThursdayStart = json['thursdayStart'] as String?;
    var jsonThursdayEnd = json['thursdayEnd'] as String?;
    TimeRange? thursday;
    if (jsonThursdayStart != null && jsonThursdayEnd != null) {
      thursday = convertTimeRange(jsonThursdayStart, jsonThursdayEnd);
    }

    var jsonFridayStart = json['fridayStart'] as String?;
    var jsonFridayEnd = json['fridayEnd'] as String?;
    TimeRange? friday;
    if (jsonFridayStart != null && jsonFridayEnd != null) {
      friday = convertTimeRange(jsonFridayStart, jsonFridayEnd);
    }

    var jsonSaturdayStart = json['saturdayStart'] as String?;
    var jsonSaturdayEnd = json['saturdayEnd'] as String?;
    TimeRange? saturday;
    if (jsonSaturdayStart != null && jsonSaturdayEnd != null) {
      saturday = convertTimeRange(jsonSaturdayStart, jsonSaturdayEnd);
    }

    var jsonSundayStart = json['sundayStart'] as String?;
    var jsonSundayEnd = json['sundayEnd'] as String?;
    TimeRange? sunday;
    if (jsonSundayStart != null && jsonSundayEnd != null) {
      sunday = convertTimeRange(jsonSundayStart, jsonSundayEnd);
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


    return Offer(
        id,
        company,
        json["name"],
        category,
        json["categoryOffer"],
        json["descriptionOffer"],
        json["photo"],
        typeOffer,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
        created,
        updated
    );
  }

  factory Offer.toNull() {
    return Offer(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
  }

  @override
  String toString() {
    return '{id: $id, company: $company, name: $name, category: $category, categoryOffer: $categoryOffer, descriptionOffer: $descriptionOffer, photo: $photo, typeOffer: $typeOffer, monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday, created: $created, updated: $updated}';
  }
}