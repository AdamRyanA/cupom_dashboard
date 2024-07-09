import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:intl/intl.dart';

String timeRangeConvert(TimeRange? timeRange) {
  String? result = "Fechado";
  if (timeRange != null) {
    String start = "${timeRange.startTime.hour.toString().padRight(2, "0")}:${timeRange.startTime.minute.toString().padRight(2, "0")}";
    String end = "${timeRange.endTime.hour.toString().padRight(2, "0")}:${timeRange.endTime.minute.toString().padRight(2, "0")}";
    result = "$start às $end";
  }
  return result;
}

TimeRange? convertTimeRange(String? timeStart, String? timeEnd) {
  TimeRange? result;
  if (timeStart != null && timeEnd != null) {
    TimeOfDay? start = parseTimeOfDay(timeStart);
    TimeOfDay? end = parseTimeOfDay(timeEnd);
    if (start != null && end != null) {
      result = TimeRange(startTime: start, endTime: end);
    }
  }
  return result;
}

String? parseStringTimeOfDay(TimeOfDay? time) {
  String? result;
  if (time != null) {
    result = "${time.hour.toString().padRight(2, "0")}:${time.minute.toString().padRight(2, "0")}";
  }
  return result;
}

TimeOfDay? parseTimeOfDay(String? time) {
  TimeOfDay? result;
  if (time != null) {
    final parts = time.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    result = TimeOfDay(hour: hour, minute: minute);
  }
  return result;
}
