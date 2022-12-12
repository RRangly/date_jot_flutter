import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

extension ContextExtensions on BuildContext {
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension DateTimeExtension on DateTime {
  String get monthString {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "errorMonth";
    }
  }

  String get dateToString {
    return "$year.$month.$day";
  }

  String get weekDayString {
    switch (weekday) {
      case 1:
        return "M";
      case 2:
        return "T";
      case 3:
        return "W";
      case 4:
        return "T";
      case 5:
        return "F";
      case 6:
        return "S";
      case 7:
        return "S";
      default:
        return "error";
    }
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get timeToString {
    return "$hour:$minute";
  }
}

extension CalendarFormatExtension on CalendarFormat {
  CalendarFormat get oppositeFormat {
    if (this == CalendarFormat.week) {
      return CalendarFormat.month;
    } else {
      return CalendarFormat.week;
    }
  }

  String get formatToString {
    if (this == CalendarFormat.week) {
      return "Week";
    } else if (this == CalendarFormat.month) {
      return "month";
    } else {
      return "error";
    }
  }
}
