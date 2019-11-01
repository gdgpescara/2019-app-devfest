import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:devfest_levante_2019/model/DevFestActivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_levante_2019/model/DevFestMiniSpeaker.dart';
import 'package:devfest_levante_2019/model/DevFestUser.dart';

class ActivitiesRepository {
  static Stream<List<DevFestActivity>> getActivities() {
    return Firestore.instance
        .collection('generatedSessions')
        .snapshots()
        .map((snapshot) => (activityMapper(snapshot, "")));
  }

  static Stream<List<DevFestActivity>> getActivitiesByDay(int day) {
    String date;
    if (day == 2) {
      date = '2019-11-02';
    }

    if (day == 3) {
      date = '2019-11-03';
    }

    return Firestore.instance
        .collection('generatedSessions')
        .orderBy("startTime")
        //.where("day", isEqualTo: date)
        .snapshots()
        .map((snapshot) => (activityMapper(snapshot, date)));
  }

  static getFavouriteActivities(List<dynamic> favourites) {
    return Firestore.instance
        .collection('generatedSessions')
        .orderBy("startTime")
        .snapshots()
        .map((snapshot) => (favouriteActivityMapper(snapshot, favourites)));
  }

  static List<DevFestActivity> favouriteActivityMapper(QuerySnapshot snapshot, List<dynamic> favourites) {
    List<DevFestActivity> activities = [];

    for (int i = 0; i < snapshot.documents.length; i++) {
      DocumentSnapshot document = snapshot.documents[i];
      var parsedActivity = activityParser(document);

      if (favourites.contains(parsedActivity.id)) {
        activities.add(parsedActivity);
      }
    }

    activities.sort((a, b) {
      var value = a.day.compareTo(b.day);
      if (value != 0) {
        return value;
      }
      return a.startTime.compareTo(b.startTime);
    });

    return activities;
  }

  static List<DevFestActivity> activityMapper(QuerySnapshot snapshot, String day) {
    List<DevFestActivity> activities = [];
    for (int i = 0; i < snapshot.documents.length; i++) {
      DocumentSnapshot document = snapshot.documents[i];
      activities.add(activityParser(document));
    }

    if (day.isNotEmpty) {
      return activities.where((a) => a.day == day).toList();
    }

    return activities;
  }

  static DevFestActivity activityParser(DocumentSnapshot document) {
    var speakers = List<DevFestMiniSpeaker>();

    List<dynamic> speakersMap = document["speakers"];
    
    for (var speaker in speakersMap) {
      speakers.add(DevFestMiniSpeaker(speaker["id"], speaker["name"]));
    }

    if (document["description"] != null) {
      return DevFestActivity(
          document["id"],
          document["title"],
          document["description"],
          document["duration"],
          document["complexity"],
          document["day"],
          document["dateReadable"],
          document["startTime"],
          document["endTime"],
          document["icon"],
          document["language"],
          document["mainTag"],
          speakers,
          [],
          document["track"]);
    } else {
      return DevFestActivity(
          document["id"],
          document["title"],
          "",
          document["duration"],
          document["complexity"],
          document["day"],
          document["dateReadable"],
          document["startTime"],
          document["endTime"],
          document["icon"],
          document["language"],
          document["mainTag"],
          speakers,
          [],
          document["track"]);
    }
  }
}
