import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_jot/Modules/account.dart';
import 'package:date_jot/Modules/event.dart';

class RepeatedEvent {
  final String eventStartingDate;
  final String eventName;
  final String eventTime;
  final String eventDetail;
  final int eventRepeatDay;
  RepeatedEvent({
    required this.eventStartingDate,
    required this.eventName,
    required this.eventTime,
    required this.eventDetail,
    required this.eventRepeatDay,
  });
  static void addRepeatingEvent(
    String eventStartingDateLocal,
    String eventNameLocal,
    String eventTimeLocal,
    String eventDetailLocal,
    int eventRepeatDayLocal,
  ) async {
    final fireBaseEventCollection = FirebaseFirestore.instance
        .collection("AccountInfos")
        .doc(Account.email.toString())
        .collection("CalendarEvents")
        .doc("RepeatingEvents")
        .collection("Events")
        .doc(eventNameLocal);
    final eventJson = {
      "eventDate": eventStartingDateLocal,
      "eventName": eventNameLocal,
      "eventTime": eventTimeLocal,
      "eventDetail": eventDetailLocal,
      "eventRepeat": eventRepeatDayLocal,
    };
    await fireBaseEventCollection.set(eventJson);
  }

  static void pushRepeatingEvent(
    RepeatedEvent eventLocal,
    String pushDateLocal,
    int pushDate,
  ) async {
    final fireBaseEventCollection = FirebaseFirestore.instance
        .collection("AccountInfos")
        .doc(Account.email.toString())
        .collection("CalendarEvents")
        .doc("RepeatingEvents")
        .collection("Events")
        .doc(eventLocal.eventName)
        .collection("PushedDates")
        .doc(pushDateLocal);
    final pushDateJson = {
      "eventPushDate": pushDateLocal,
      "eventPushAmount": pushDate,
    };
    await fireBaseEventCollection.set(pushDateJson);
  }

  static RepeatedEvent fromJson(Map<String, dynamic> json) {
    return RepeatedEvent(
      eventStartingDate: json["eventDate"],
      eventName: json["eventName"],
      eventTime: json["eventTime"],
      eventDetail: json["eventDetail"],
      eventRepeatDay: json["eventRepeat"],
    );
  }

  static bool doesEventRepeateWeekday(Map<String, dynamic> json) {
    if (json["weekDayRepeated"] != null) {
      return json["weekDayRepeated"];
    } else {
      return false;
    }
  }

  static int pushedEventAmount(Map<String, dynamic> json) {
    return json["eventPushAmount"];
  }

  static DateTime pushedEventDate(Map<String, dynamic> json) {
    final tempTime = json["eventPushDate"].toString().split('.');
    return DateTime(
      int.parse(tempTime[0]),
      int.parse(tempTime[1]),
      int.parse(tempTime[2]),
    );
  }

  static Event getEventFromRepeatedEvent(RepeatedEvent repeatedEvent) {
    return Event(
      eventDate: repeatedEvent.eventStartingDate,
      eventDetail: repeatedEvent.eventDetail,
      eventName: repeatedEvent.eventName,
      eventTime: repeatedEvent.eventTime,
    );
  }

  static Future<List<RepeatedEvent>> fetchRepeatedEventsAsFuture(
      String eventDateLocal) async {
    final eventTimeTemp = eventDateLocal.split('.');
    DateTime eventTime = DateTime(
      int.parse(eventTimeTemp[0]),
      int.parse(eventTimeTemp[1]),
      int.parse(eventTimeTemp[2]),
    );
    print("eventfuturestart");
    List<RepeatedEvent> repeatedEvents = [];
    final tempRepEvents = await FirebaseFirestore.instance
        .collection("AccountInfos")
        .doc(Account.email.toString())
        .collection("CalendarEvents")
        .doc("RepeatingEvents")
        .collection("Events")
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return doc;
          },
        ).toList();
      },
    ).first;
    print("startingRepEventPushCalculation");
    for (int i = 0; i < tempRepEvents.length; i++) {
      final repEventData = RepeatedEvent.fromJson(tempRepEvents[i].data());
      final weekdayReapeated =
          RepeatedEvent.doesEventRepeateWeekday(tempRepEvents[i].data());
      final pushedDates = await tempRepEvents[i]
          .reference
          .collection("PushedDates")
          .snapshots()
          .map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              return doc.data();
            },
          ).toList();
        },
      ).first;
      final pushedDateAmount = pushedDates.map(
        (doc) {
          return pushedEventAmount(doc);
        },
      ).toList();
      final pushedDateDate = pushedDates.map(
        (doc) {
          return pushedEventDate(doc);
        },
      ).toList();
      final repeatedEventMap = repEventData;
      final tempRepEventStartDate =
          repeatedEventMap.eventStartingDate.split('.');
      DateTime yMD = DateTime(
        int.parse(tempRepEventStartDate[0]),
        int.parse(tempRepEventStartDate[1]),
        int.parse(tempRepEventStartDate[2]),
      );
      for (int i = 0; i < pushedDateDate.length; i++) {
        if (pushedDateDate[i].year < eventTime.year ||
            pushedDateDate[i].month < eventTime.month ||
            pushedDateDate[i].day < eventTime.day) {
          yMD.add(
            Duration(
              days: pushedDateAmount[i],
            ),
          );
        }
      }
      while (yMD.year < eventTime.year ||
          yMD.month < eventTime.month ||
          yMD.day < eventTime.day) {
        print(
          "triedRepeatedEvent: ${repeatedEventMap.eventName} | ${yMD.year}.${yMD.month}.${yMD.day}",
        );
        if (weekdayReapeated) {
          if (yMD.weekday == DateTime.sunday) {
            yMD.add(
              const Duration(
                days: 1,
              ),
            );
          } else if (yMD.weekday == DateTime.saturday) {
            yMD.add(
              const Duration(
                days: 2,
              ),
            );
          }
        }
        yMD = yMD.add(
          Duration(
            days: repeatedEventMap.eventRepeatDay,
          ),
        );
      }
      if (yMD.year == eventTime.year &&
          yMD.month == eventTime.month &&
          yMD.day == eventTime.day) {
        print(
          "repeatedEvent: ${repeatedEventMap.eventName} | ${yMD.year}.${yMD.month}.${yMD.day}",
        );
        repeatedEvents.add(repeatedEventMap);
      } else {
        print(
            "repeatedEvent: ${repeatedEventMap.eventName} |fail| ${yMD.year}.${yMD.month}.${yMD.day}");
      }
    }
    return repeatedEvents;
  }
}
