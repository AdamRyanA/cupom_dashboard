import 'package:time_range_picker/time_range_picker.dart';

String timeRangeConvert(TimeRange? timeRange) {
  String? result = "Fechado";
  if (timeRange != null) {
    String start = "${timeRange.startTime.hour.toString().padRight(2, "0")}:${timeRange.startTime.minute.toString().padRight(2, "0")}";
    String end = "${timeRange.endTime.hour.toString().padRight(2, "0")}:${timeRange.endTime.minute.toString().padRight(2, "0")}";
    result = "$start às $end";
  }
  return result;
}