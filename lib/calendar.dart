import 'dart:async';
import 'package:date_jot/custom_settings.dart';
import 'package:date_jot/custom_widgets.dart';
import 'package:date_jot/event.dart';
import 'package:date_jot/extensions.dart';
import 'package:date_jot/repeated_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar {
  static OverlayEntry? overLayMenu;
  static CalendarFormat calendarFormat = CalendarFormat.month;
  static DateTime selectedDay = DateTime.now();
  static TimeOfDay selectedTime = TimeOfDay.now();
  static DateTime focusedDay = DateTime.now();
  static void hideOverLays() {
    if (Calendar.overLayMenu != null) {
      Calendar.overLayMenu!.remove();
      Calendar.overLayMenu!.dispose();
      Calendar.overLayMenu = null;
    }
  }

  static Future<TimeOfDay> openTimePicker(
    BuildContext context,
  ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: 12,
        minute: 0,
      ),
    );
    selectedTime = time!;
    return time;
  }

  static List<List<DateTime>> daysInMonth(
    DateTime wantedMonth,
  ) {
    DateTime firstDate = wantedMonth.subtract(
      Duration(days: wantedMonth.day - 1),
    );
    final lastDayOfMonth = DateTime(
      Calendar.selectedDay.year,
      Calendar.selectedDay.month + 1,
      0,
    );

    List<DateTime> monCalendar = <DateTime>[];
    List<DateTime> tueCalendar = <DateTime>[];
    List<DateTime> wedCalendar = <DateTime>[];
    List<DateTime> thuCalendar = <DateTime>[];
    List<DateTime> friCalendar = <DateTime>[];
    List<DateTime> satCalendar = <DateTime>[];
    List<DateTime> sunCalendar = <DateTime>[];
    for (DateTime i = firstDate; i.weekday > 1;) {
      i = DateTime(
        i.year,
        i.month,
        i.day - 1,
      );
      final weekDay = i.weekday;
      switch (weekDay) {
        case 1:
          monCalendar.add(i);
          break;
        case 2:
          tueCalendar.add(i);
          break;
        case 3:
          wedCalendar.add(i);
          break;
        case 4:
          thuCalendar.add(i);
          break;
        case 5:
          friCalendar.add(i);
          break;
        case 6:
          satCalendar.add(i);
          break;
        case 7:
          sunCalendar.add(i);
          break;
        default:
      }
    }
    for (DateTime i = firstDate; i.day <= lastDayOfMonth.day;) {
      final weekDay = i.weekday;
      switch (weekDay) {
        case 1:
          monCalendar.add(i);
          break;
        case 2:
          tueCalendar.add(i);
          break;
        case 3:
          wedCalendar.add(i);
          break;
        case 4:
          thuCalendar.add(i);
          break;
        case 5:
          friCalendar.add(i);
          break;
        case 6:
          satCalendar.add(i);
          break;
        case 7:
          sunCalendar.add(i);
          break;
        default:
      }
      i = DateTime(
        i.year,
        i.month,
        i.day + 1,
      );
      if (i.day == 1) {
        break;
      }
    }
    for (DateTime i = lastDayOfMonth; i.weekday < 7;) {
      i = DateTime(
        i.year,
        i.month,
        i.day + 1,
      );
      final weekDay = i.weekday;
      switch (weekDay) {
        case 1:
          monCalendar.add(i);
          break;
        case 2:
          tueCalendar.add(i);
          break;
        case 3:
          wedCalendar.add(i);
          break;
        case 4:
          thuCalendar.add(i);
          break;
        case 5:
          friCalendar.add(i);
          break;
        case 6:
          satCalendar.add(i);
          break;
        case 7:
          sunCalendar.add(i);
          break;
        default:
          break;
      }
    }
    return [
      monCalendar,
      tueCalendar,
      wedCalendar,
      thuCalendar,
      friCalendar,
      satCalendar,
      sunCalendar,
    ];
  }

  static Widget displayCalendarWeek(
    DateTime selectedDate,
    double blockSize,
  ) {
    List<DateTime> weekdays = [];
    final firstDayOfWeek = DateTime(
      focusedDay.year,
      focusedDay.month,
      1 + focusedDay.day - focusedDay.weekday,
    );
    for (int i = 0; i < 7; i++) {
      weekdays.add(
        DateTime(
          firstDayOfWeek.year,
          firstDayOfWeek.month,
          firstDayOfWeek.day + i,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCalendarWeekDay(weekdays[0], blockSize),
        SizedBox(width: blockSize * 0.2),
        buildCalendarWeekDay(weekdays[1], blockSize),
        SizedBox(width: blockSize * 0.2),
        buildCalendarWeekDay(weekdays[2], blockSize),
        SizedBox(width: blockSize * 0.2),
        buildCalendarWeekDay(weekdays[3], blockSize),
        SizedBox(width: blockSize * 0.2),
        buildCalendarWeekDay(weekdays[4], blockSize),
        SizedBox(width: blockSize * 0.2),
        buildCalendarWeekDay(weekdays[5], blockSize),
        SizedBox(width: blockSize * 0.2),
        buildCalendarWeekDay(weekdays[6], blockSize),
      ],
    );
  }

  static Widget displayCalendar(
    DateTime wantedTime,
    double blockSize,
  ) {
    final daysInMonth = Calendar.daysInMonth(wantedTime);
    final monCalendar = daysInMonth[0];
    final tueCalendar = daysInMonth[1];
    final wedCalendar = daysInMonth[2];
    final thuCalendar = daysInMonth[3];
    final friCalendar = daysInMonth[4];
    final satCalendar = daysInMonth[5];
    final sunCalendar = daysInMonth[6];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: calendarMonthEachColumn(
            "MON",
            monCalendar,
            blockSize,
          ),
        ),
        SizedBox(width: blockSize * 0.2),
        Column(
          children: calendarMonthEachColumn(
            "TUE",
            tueCalendar,
            blockSize,
          ),
        ),
        SizedBox(width: blockSize * 0.2),
        Column(
          children: calendarMonthEachColumn(
            "WED",
            wedCalendar,
            blockSize,
          ),
        ),
        SizedBox(width: blockSize * 0.2),
        Column(
          children: calendarMonthEachColumn(
            "THU",
            thuCalendar,
            blockSize,
          ),
        ),
        SizedBox(width: blockSize * 0.2),
        Column(
          children: calendarMonthEachColumn(
            "FRI",
            friCalendar,
            blockSize,
          ),
        ),
        SizedBox(width: blockSize * 0.2),
        Column(
          children: calendarMonthEachColumn(
            "SAT",
            satCalendar,
            blockSize,
          ),
        ),
        SizedBox(width: blockSize * 0.2),
        Column(
          children: calendarMonthEachColumn(
            "SUN",
            sunCalendar,
            blockSize,
          ),
        ),
      ],
    );
  }

  static List<Widget> calendarMonthEachColumn(
    String dayOfWeek,
    List<DateTime> days,
    double blockSize,
  ) {
    return [
      Text(
        dayOfWeek,
        style: const TextStyle(
          fontFamily: "WorkSansRegular",
          color: Colors.black,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
      ...days.map(
        (date) {
          return Calendar.buildCalendarDay(
            date,
            blockSize,
          );
        },
      ).toList(),
    ];
  }

  static Widget buildCalendarDay(
    DateTime eventTime,
    double size,
  ) {
    if (eventTime ==
        DateTime(
          Calendar.selectedDay.year,
          Calendar.selectedDay.month,
          Calendar.selectedDay.day,
        )) {
      return InkWell(
        onTap: () {
          CalendarScreenState.selectedDateUpdate(eventTime);
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: CustomSettings.mainGreen,
            borderRadius: BorderRadius.circular(500),
          ),
          child: Center(
            child: Text(
              eventTime.day.toString(),
              style: const TextStyle(
                fontFamily: "WorkSansRegular",
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else if (eventTime.month == Calendar.focusedDay.month) {
      return InkWell(
        onTap: () {
          CalendarScreenState.selectedDateUpdate(eventTime);
        },
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Text(
              eventTime.day.toString(),
              style: const TextStyle(
                fontFamily: "WorkSansRegular",
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          CalendarScreenState.selectedDateUpdate(eventTime);
        },
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Text(
              eventTime.day.toString(),
              style: TextStyle(
                fontFamily: "WorkSansRegular",
                color: Colors.black.withOpacity(0.6),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }

  static Widget buildCalendarWeekDay(DateTime date, double blockSize) {
    return FutureBuilder<List<Event>>(
      future: Event.fetchEventsAsFuture(
        date.dateToString,
      ),
      builder: (context, normEventsnapshot) {
        List<Event> normEvents = [];
        if (normEventsnapshot.hasData) {
          normEvents.addAll(normEventsnapshot.data!);
        }
        return FutureBuilder<List<RepeatedEvent>>(
          future: RepeatedEvent.fetchRepeatedEventsAsFuture(
            Calendar.selectedDay.dateToString,
          ),
          builder: (context, repEventSnapshot) {
            List<RepeatedEvent> repEvents = [];
            if (repEventSnapshot.hasData) {
              repEvents.addAll(repEventSnapshot.data!);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  date.weekDayString,
                  style: const TextStyle(
                    fontFamily: "WorkSansMedium",
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                buildCalendarDay(date, blockSize),
                ...repEvents.map(
                  (repEvent) {
                    return Calendar.buildRepeatedEvent(
                      context,
                      repEvent,
                      blockSize,
                      blockSize * 2,
                    );
                  },
                ),
                ...normEvents.map(
                  (normEvent) {
                    return Calendar.buildEvent(
                      context,
                      normEvent,
                      blockSize,
                      blockSize * 2,
                    );
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  static void addEventMenu(
    BuildContext context,
    double width,
    double height,
  ) {
    final List<TextEditingController> textEConts = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
    Calendar.overLayMenu = OverlayEntry(
      builder: (context) {
        return Container(
          width: width / 0.8,
          height: height / 0.5,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        SizedBox(width: width * 0.34),
                        SizedBox(
                          width: width * 0.3,
                          child: const Text(
                            "Add Event",
                            style: TextStyle(
                              fontFamily: "WorkSansMedium",
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: width * 0.2),
                        IconButton(
                          onPressed: () {
                            hideOverLays();
                          },
                          icon: const Icon(Icons.close),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                    CustomWidgets.inputBox(
                      width * 0.9,
                      height * 0.1,
                      "null",
                      "Event Name",
                      CustomSettings.mainGreen,
                      2,
                      20,
                      14,
                      6,
                      textEConts[0],
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            hideOverLays();
                            await openTimePicker(context);
                            if (!context.mounted) return;
                            addEventMenu(context, width, height);
                          },
                          child: Container(
                            width: width * 0.45,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: CustomSettings.mainGreen,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${Calendar.selectedTime.hour}:${Calendar.selectedTime.minute}",
                                style: const TextStyle(
                                  fontFamily: "WorkSansMedium",
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomSettings.mainGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: width * 0.9,
                        height: height * 0.45,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          controller: textEConts[1],
                          maxLines: 7,
                          style: TextStyle(
                            fontFamily: "WorkSansMedium",
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 14,
                            ),
                            hintText: "Details",
                            hintStyle: TextStyle(
                              fontFamily: "WorkSansMedium",
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    TextButton(
                      onPressed: () async {
                        if (textEConts[2].text == "" ||
                            textEConts[2].text == "0") {
                          Event.addEvent(
                            Calendar.selectedDay.dateToString,
                            textEConts[0].text,
                            Calendar.selectedTime.timeToString,
                            textEConts[1].text,
                          );
                        } else {
                          RepeatedEvent.addRepeatingEvent(
                            Calendar.selectedDay.dateToString,
                            textEConts[0].text,
                            Calendar.selectedTime.timeToString,
                            textEConts[1].text,
                            int.parse(textEConts[2].text),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: CustomSettings.mainGreen,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: height * 0.1,
                        width: width * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Done",
                              style: TextStyle(
                                fontFamily: "WorkSansMedium",
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    final overLay = Overlay.of(context)!;
    overLay.insert(overLayMenu!);
  }

  static void showEventsMenu(
    BuildContext context,
    double width,
    double height,
  ) {
    overLayMenu = OverlayEntry(
      builder: (context) {
        return Container(
          width: width / 0.8,
          height: height / 0.5,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: width * 0.35),
                        SizedBox(
                          width: width * 0.3,
                          child: const Text(
                            "Events",
                            style: TextStyle(
                              fontFamily: "WorkSansMedium",
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: width * 0.19),
                        IconButton(
                          onPressed: () {
                            hideOverLays();
                          },
                          icon: const Icon(Icons.close),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FutureBuilder<List<Event>>(
                        future: Event.fetchEventsAsFuture(
                          Calendar.selectedDay.dateToString,
                        ),
                        builder: (context, normEventsnapshot) {
                          List<Event> normEvents = [];
                          if (normEventsnapshot.hasData) {
                            normEvents.addAll(normEventsnapshot.data!);
                          }
                          return FutureBuilder<List<RepeatedEvent>>(
                            future: RepeatedEvent.fetchRepeatedEventsAsFuture(
                              Calendar.selectedDay.dateToString,
                            ),
                            builder: (context, repEventSnapshot) {
                              List<RepeatedEvent> repEvents = [];
                              if (repEventSnapshot.hasData) {
                                repEvents.addAll(repEventSnapshot.data!);
                              }
                              return ListView(
                                padding: const EdgeInsets.all(0),
                                children: [
                                  ...repEvents.map(
                                    (repEvent) {
                                      return Calendar.buildRepeatedEvent(
                                        context,
                                        repEvent,
                                        width * 0.8,
                                        height * 0.1,
                                      );
                                    },
                                  ),
                                  ...normEvents.map(
                                    (normEvent) {
                                      return Calendar.buildEvent(
                                        context,
                                        normEvent,
                                        width * 0.8,
                                        height * 0.1,
                                      );
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    final overLay = Overlay.of(context)!;
    overLay.insert(overLayMenu!);
  }

  static Widget buildEvent(
    BuildContext context,
    Event event,
    double width,
    double height,
  ) {
    return InkWell(
      onTap: () {
        hideOverLays();
        showEventDetails(context, event);
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Column(children: [
          Text(
            event.eventName,
            style: const TextStyle(
              fontFamily: "WorkSansMedium",
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            "${event.eventDate} | ${event.eventTime} | normalEvent",
            style: const TextStyle(
              fontFamily: "WorkSansMedium",
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ]),
      ),
    );
  }

  static Widget buildRepeatedEvent(
    BuildContext context,
    RepeatedEvent event,
    double width,
    double height,
  ) {
    return InkWell(
      onTap: () {
        hideOverLays();
        showRepeatedEventDetails(context, event);
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Column(children: [
          Text(
            event.eventName,
            style: const TextStyle(
              fontFamily: "WorkSansMedium",
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            "${event.eventStartingDate} | ${event.eventTime} | repeatedEvent",
            style: const TextStyle(
              fontFamily: "WorkSansMedium",
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ]),
      ),
    );
  }

  static void showEventDetails(
    BuildContext context,
    Event eventLocal,
  ) {
    overLayMenu = OverlayEntry(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth * 0.8;
            final height = constraints.maxHeight * 0.5;
            return Container(
              width: width / 0.8,
              height: height / 0.5,
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: width * 0.35),
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                eventLocal.eventName,
                                style: const TextStyle(
                                  fontFamily: "WorkSansMedium",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: width * 0.19),
                            IconButton(
                              onPressed: () {
                                hideOverLays();
                              },
                              icon: const Icon(Icons.close),
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ],
                        ),
                        Text(
                          "${eventLocal.eventDate}\n${eventLocal.eventTime}",
                          style: const TextStyle(
                            fontFamily: "WorkSansMedium",
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          eventLocal.eventDetail,
                          style: const TextStyle(
                            fontFamily: "WorkSansRegular",
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () async {
                            Event.deleteEvent(
                              eventLocal.eventDate,
                              eventLocal.eventName,
                            );
                            showEventsMenu(context, width, height);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                CustomSettings.defaultBoxShadowFun(8)
                              ],
                            ),
                            height: height * 0.06,
                            width: width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Delete this event",
                                  style: TextStyle(
                                    fontFamily: "WorkSansMedium",
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    final overLay = Overlay.of(context)!;
    overLay.insert(overLayMenu!);
  }

  static void showRepeatedEventDetails(
    BuildContext context,
    RepeatedEvent eventLocal,
  ) {
    overLayMenu = OverlayEntry(
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth * 0.8;
            final height = constraints.maxHeight * 0.5;
            return Container(
              width: width / 0.8,
              height: height / 0.5,
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: width * 0.35),
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                eventLocal.eventName,
                                style: const TextStyle(
                                  fontFamily: "WorkSansMedium",
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: width * 0.19),
                            IconButton(
                              onPressed: () {
                                hideOverLays();
                              },
                              icon: const Icon(Icons.close),
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ],
                        ),
                        Text(
                          "${eventLocal.eventStartingDate}\n${eventLocal.eventTime}",
                          style: const TextStyle(
                            fontFamily: "WorkSansMedium",
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "repeated every ${eventLocal.eventRepeatDay} days",
                          style: const TextStyle(
                            fontFamily: "WorkSansMedium",
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          eventLocal.eventDetail,
                          style: const TextStyle(
                            fontFamily: "WorkSansRegular",
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () async {
                            Event.deleteEvent(
                              eventLocal.eventStartingDate,
                              eventLocal.eventName,
                            );
                            showEventsMenu(context, width, height);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                CustomSettings.defaultBoxShadowFun(8)
                              ],
                            ),
                            height: height * 0.06,
                            width: width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Delete this event",
                                  style: TextStyle(
                                    fontFamily: "WorkSansMedium",
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    final overLay = Overlay.of(context)!;
    overLay.insert(overLayMenu!);
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  static Function selectedDateUpdate = () {};
  callBack(DateTime wantedDate) {
    setState(
      () {
        Calendar.selectedDay = wantedDate;
        Calendar.focusedDay = wantedDate;
      },
    );
  }
  @override
  void initState() {
    selectedDateUpdate = callBack;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        return CustomWidgets.bottomOverLay(context);
      },
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    /*WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return CustomWidgets.topBar(
          context,
          width,
          height * 0.2,
        );
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Scaffold(
          
          body: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              /*TableCalendar(
                //setup
                focusedDay: Calendar.focusedDay,
                firstDay:
                    DateTime.now().subtract(const Duration(days: 365 * 10)),
                lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                daysOfWeekVisible: true,
                calendarFormat: Calendar.calendarFormat,
                //styles
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonShowsNext: false,
                ),
                //Functions
                onFormatChanged: (CalendarFormat formatLocal) {
                  setState(() {
                    if (formatLocal == CalendarFormat.twoWeeks) {
                      Calendar.calendarFormat = CalendarFormat.week;
                    } else {
                      Calendar.calendarFormat = formatLocal;
                    }
                  });
                },
                onDaySelected:
                    (DateTime selectedDayLocal, DateTime focusedDayLocal) {
                  setState(
                    () {
                      Calendar.selectedDay = selectedDayLocal;
                      Calendar.focusedDay = focusedDayLocal;
                    },
                  );
                },
                pageJumpingEnabled: true,
                onPageChanged: (focusedDayLocal) {
                  Calendar.focusedDay = focusedDayLocal;
                },
                selectedDayPredicate: (DateTime dateLocal) {
                  return isSameDay(Calendar.selectedDay, dateLocal);
                },
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (Calendar.calendarFormat == CalendarFormat.month) {
                        setState(() {
                          Calendar.focusedDay = DateTime(
                            Calendar.focusedDay.year,
                            Calendar.focusedDay.month - 1,
                            Calendar.focusedDay.day,
                          );
                        });
                      } else if (Calendar.calendarFormat ==
                          CalendarFormat.week) {
                        setState(() {
                          Calendar.focusedDay = DateTime(
                            Calendar.focusedDay.year,
                            Calendar.focusedDay.month,
                            Calendar.focusedDay.day - 7,
                          );
                        });
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                    ),
                  ),
                  SizedBox(width: width * 0.05),
                  Text(
                    "${Calendar.focusedDay.monthString} ${Calendar.focusedDay.year}",
                    style: const TextStyle(
                      fontFamily: "WorkSansMedium",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: width * 0.25),
                  InkWell(
                    onTap: () {
                      if (Calendar.calendarFormat == CalendarFormat.month) {
                        setState(() {
                          Calendar.calendarFormat = CalendarFormat.week;
                        });
                      } else {
                        setState(() {
                          Calendar.calendarFormat = CalendarFormat.month;
                        });
                      }
                    },
                    child: Container(
                      width: width * 0.2,
                      height: height * 0.03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          Calendar.calendarFormat.oppositeFormat.formatToString,
                          style: const TextStyle(
                            fontFamily: "WorkSansMedium",
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.05),
                  InkWell(
                    onTap: () {
                      if (Calendar.calendarFormat == CalendarFormat.month) {
                        setState(() {
                          Calendar.focusedDay = DateTime(
                            Calendar.focusedDay.year,
                            Calendar.focusedDay.month + 1,
                            Calendar.focusedDay.day,
                          );
                        });
                      } else if (Calendar.calendarFormat ==
                          CalendarFormat.week) {
                        setState(() {
                          Calendar.focusedDay = DateTime(
                            Calendar.focusedDay.year,
                            Calendar.focusedDay.month,
                            Calendar.focusedDay.day + 7,
                          );
                        });
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  ),
                ],
              ),
              if (Calendar.calendarFormat == CalendarFormat.week)
                Calendar.displayCalendarWeek(
                  Calendar.focusedDay,
                  width * 0.11,
                ),
              if (Calendar.calendarFormat == CalendarFormat.month)
                Calendar.displayCalendar(
                  Calendar.focusedDay,
                  width * 0.11,
                ),
              SizedBox(height: height * 0.01),
              TextButton(
                onPressed: () async {
                  Calendar.addEventMenu(context, width * 0.8, height * 0.5);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [CustomSettings.defaultBoxShadowFun(8)],
                  ),
                  height: height * 0.06,
                  width: width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Add Event",
                        style: TextStyle(
                          fontFamily: "WorkSansMedium",
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Calendar.showEventsMenu(context, width * 0.8, height * 0.5);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [CustomSettings.defaultBoxShadowFun(8)],
                  ),
                  height: height * 0.06,
                  width: width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Show Events",
                        style: TextStyle(
                          fontFamily: "WorkSansMedium",
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
