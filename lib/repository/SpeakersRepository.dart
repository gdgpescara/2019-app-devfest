import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_levante_2019/model/DevFestMiniSpeaker.dart';
import 'package:devfest_levante_2019/model/DevFestSpeaker.dart';

class SpeakersRepository {
  List<DevFestSpeaker> speakers;

  SpeakersRepository.fromSpeakers(this.speakers);

  static Future<List<DevFestSpeaker>> getSpeakers() async {
    return (await Firestore.instance
        .collection('generatedSpeakers')
        .getDocuments())
        .documents
        .map((snapshot){
          return parseSpeaker(snapshot);
        }).toList();
  }

  static List<DevFestSpeaker> speakersMapper(QuerySnapshot snapshot) {
    List<DevFestSpeaker> speakers = [];

    for (int i = 0; i < snapshot.documents.length; i++) {
      DocumentSnapshot document = snapshot.documents[i];
      speakers.add(parseSpeaker(document));
    }

    return speakers;
  }

  static DevFestSpeaker parseSpeaker(DocumentSnapshot document) {

    try {
      return DevFestSpeaker(
          document["id"],
          document["bio"],
          document["name"],
          document["company"],
          document["companyLogoUrl"],
          document["country"],
          document["order"],
          document["photoUrl"],
          document["shortBio"],
          document["sessions"],
          document["tags"],
          document["badges"],
          document["title"],);
    } catch (e) {
      return DevFestSpeaker("", "", "", "", "", "", 0, "", "", [], [], [], "");
    }
  }

  List<DevFestSpeaker> getSpeakersById(List<DevFestMiniSpeaker> metaSpeakers) {
    List<String> ids = List();
    for (var s in metaSpeakers) {
      ids.add(s.id);
    }

    List<DevFestSpeaker> finalSpeakers = List();
    for (var s in speakers) {
      if (ids != null && s != null) {
        if (ids.contains(s.id)) {
          finalSpeakers.add(s);
        }
      }
    }

    return finalSpeakers;
  }
}
