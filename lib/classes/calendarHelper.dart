import 'package:device_calendar/device_calendar.dart';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'Models/termin.dart';

class CalendarHelper {
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  CalendarHelper() {
    loadData();
  }

  Future<List<Calendar>> loadAllCalendars() async {
    var allCalendars = await _deviceCalendarPlugin.retrieveCalendars();
    var calendars = allCalendars.data?.toList();

    if (calendars != null) {
      calendars.forEach((element) {});
      return calendars;
    } else {
      [];
    }
    return [];
    //return calendars;
  }

  void isCalendarEntryInCalendar(
    String title,
  ) {}

  Future<void> loadData() async {
    await _deviceCalendarPlugin.requestPermissions();
    tz.initializeTimeZones();
    final locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));

    var m = _deviceCalendarPlugin.hasPermissions();

    //print(tz.TZDateTime.now(tz.local));

    // var allCalendars = await _deviceCalendarPlugin.retrieveCalendars();
    // var calendars = allCalendars.data?.toList();
    // var allEvents = await _deviceCalendarPlugin.retrieveEvents(
    //     "7F98F756-D50E-4CF3-9E34-DF5C2D8454F8",
    //     RetrieveEventsParams(
    //       startDate: DateTime.now(),
    //       endDate: DateTime.now().add(const Duration(days: 7)),
    //     ));

    // var allEventsList = allEvents.data?.toList();

    // calendars?.forEach((element) {
    //   print("${element.name} + ${element.accountType} + ${element.id}");
    // });
  }

  static Event createEventFromTermin(Termin termin, String calenderId,
      {String? eventId = ""}) {
    Event _event;
    if (eventId != "") {
      _event = Event(
        calenderId,
        eventId: eventId,
        availability: Availability.Busy,
        location: termin.adresse,
        title: termin.name,
        start: tz.TZDateTime.from(termin.terminAsDateTime, tz.local),
        allDay: false,
        description:
            generateDesc(termin.notizen, termin.kleidung, termin.treffpunkt),
        end: tz.TZDateTime.from(termin.terminAsDateTime, tz.local)
            .add(Duration(hours: 4)),
      );
    } else {
      _event = Event(
        calenderId,
        availability: Availability.Busy,
        location: termin.adresse,
        title: termin.name,
        start: tz.TZDateTime.from(termin.terminAsDateTime, tz.local),
        allDay: false,
        description:
            generateDesc(termin.notizen, termin.kleidung, termin.treffpunkt),
        end: tz.TZDateTime.from(termin.terminAsDateTime, tz.local)
            .add(Duration(hours: 4)),
      );
    }

    return _event;
  }

  Future<void> lookAllCalendarsForTheEntrie(Termin t) async {
    var allCals = await _deviceCalendarPlugin.retrieveCalendars();
    var list = allCals.data?.toList();

    var isAlreadIn = false;
    var isAlreadyInEvent = Event("calendarId");

    for (var item in list!) {
      var entriesFromTermin = await _deviceCalendarPlugin.retrieveEvents(
          item.id,
          RetrieveEventsParams(
            startDate: t.terminAsDateTime,
            endDate: t.terminAsDateTime.add(const Duration(days: 1)),
          ));

      var allEntries = entriesFromTermin.data?.toList();

      allEntries?.forEach((element) async {
        if (element.title == t.name) {
          isAlreadIn = true;
          isAlreadyInEvent = element;

          var m = _deviceCalendarPlugin.deleteEvent(item.id, element.eventId);

          //existingEventId = element.eventId;
        }
      });
    }

    // var entriesFromTermin = await _deviceCalendarPlugin.retrieveEvents(
    //     "calId",
    //     RetrieveEventsParams(
    //       startDate: t.terminAsDateTime,
    //       endDate: t.terminAsDateTime.add(const Duration(days: 1)),
    //     ));

    // bool isAlreadIn = false;
    // var allEntries = entriesFromTermin.data?.toList();

    // allEntries?.forEach((element) {
    //   if (element.title == t.name) {
    //     isAlreadIn = true;
    //     //isAlreadyInEvent = element;
    //     //existingEventId = element.eventId;
    //   }
    // });
  }

  Future<bool> addEvent(Termin t, String calId) async {
    loadData();

    var m = createEventFromTermin(t, calId);

    var entriesFromTermin = await _deviceCalendarPlugin.retrieveEvents(
        calId,
        RetrieveEventsParams(
          startDate: t.terminAsDateTime,
          endDate: t.terminAsDateTime.add(const Duration(days: 1)),
        ));

    bool isAlreadIn = false;

    //Event isAlreadyInEvent = Event("");
    String? existingEventId = "";

    var allEntries = entriesFromTermin.data?.toList();

    allEntries?.forEach((element) {
      if (element.title == t.name) {
        isAlreadIn = true;
        //isAlreadyInEvent = element;
        existingEventId = element.eventId;
      }
    });

    var updatedEvent =
        createEventFromTermin(t, calId, eventId: existingEventId);
    //var added = await _deviceCalendarPlugin.createOrUpdateEvent(m);

    if (isAlreadIn == false) {
      //nicht drinnen
      var added = await _deviceCalendarPlugin.createOrUpdateEvent(m);
      return added!.isSuccess ? true : false;
    }

    //! testen
    if (isAlreadIn == true) {
      //drinnen
      var added = await _deviceCalendarPlugin.createOrUpdateEvent(updatedEvent);

      return added!.isSuccess ? true : false;
    }

    return false;
  }

  Future<bool> delEvent(String calId, String eventId) async {
    var result = await _deviceCalendarPlugin.deleteEvent(calId, eventId);

    return result.isSuccess;
  }

  static String generateDesc(
      String notizen, String kleidung, String treffpunk) {
    String desc = "";

    desc += "Notizen: $notizen \n\n";
    desc += "Kleidung: $kleidung \n\n";
    desc += "Treffpunkt: $treffpunk \n\n";

    //print(desc);

    return desc;
  }
}
