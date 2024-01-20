import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_jot/Modules/account.dart';
import '../../LegacyLib/ScreensLegacy/calendar.dart';
import 'package:date_jot/Modules/custom_settings.dart';
import 'package:date_jot/Modules/repeated_event.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Event {
  final String eventDate;
  final String eventName;
  final String eventTime;
  final String eventDetail;
  Event({
    required this.eventDate,
    required this.eventName,
    required this.eventTime,
    required this.eventDetail,
  });
  static void addEvent(
    String eventDateLocal,
    String eventNameLocal,
    String eventTimeLocal,
    String eventDetailLocal,
  ) async {
    final fireBaseEventCollection = FirebaseFirestore.instance.collection("AccountInfos").doc(Account.email.toString()).collection("CalendarEvents").doc(eventDateLocal).collection("EventsForTheDay").doc(eventNameLocal);
    final eventJson = {
      "eventDate": eventDateLocal,
      "eventName": eventNameLocal,
      "eventTime": eventTimeLocal,
      "eventDetail": eventDetailLocal,
    };
    await fireBaseEventCollection.set(eventJson);
  }

  static void deleteEvent(
    String eventDateLocal,
    String eventNameLocal,
  ) {
    final fireBaseNormalEventCollection = FirebaseFirestore.instance.collection("AccountInfos").doc(Account.email.toString()).collection("CalendarEvents").doc(eventDateLocal).collection("EventsForTheDay").doc(eventNameLocal);
    fireBaseNormalEventCollection.delete();
    final firebaseRepEventCollection = FirebaseFirestore.instance.collection("AccountInfos").doc(Account.email.toString()).collection("CalendarEvents").doc("RepeatingEvents").collection("Events").doc(eventNameLocal);
    firebaseRepEventCollection.delete();
  }

  static Future<List<Event>> fetchEventsAsFuture(String eventDateLocal) async {
    final eventTimeTemp = eventDateLocal.split('.');
    DateTime eventTime = DateTime(
      int.parse(eventTimeTemp[0]),
      int.parse(eventTimeTemp[1]),
      int.parse(eventTimeTemp[2]),
    );
    print("eventfuturestart");
    final normalEvents = await FirebaseFirestore.instance.collection("AccountInfos").doc(Account.email.toString()).collection("CalendarEvents").doc(eventDateLocal).collection("EventsForTheDay").snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return Event.fromJson(doc.data());
          },
        ).toList();
      },
    ).first;
    print("eventdone");
    for (int i = 0; i < normalEvents.length; i++) {
      print("normalEventDone : ${normalEvents[i].eventName}");
    }
    print("returning");
    return normalEvents;
  }

  static Event fromJson(Map<String, dynamic> json) {
    return Event(
      eventDate: json["eventDate"],
      eventName: json["eventName"],
      eventTime: json["eventTime"],
      eventDetail: json["eventDetail"],
    );
  }
}
