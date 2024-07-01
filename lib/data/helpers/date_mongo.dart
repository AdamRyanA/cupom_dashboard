
class DateMongo {
  String date;

  DateMongo(this.date);

  factory DateMongo.fromJson(dynamic json) {
    DateTime datetime = DateTime.parse(json["\$date"]).toLocal();
    return DateMongo(datetime.toString());
  }

  @override
  String toString() {
    return date;
  }
}