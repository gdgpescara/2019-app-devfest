import 'package:devfest_levante_2019/model/DevFestMiniSpeaker.dart';

class DevFestActivity {
  String id;
  String title;
  String description;
  Map duration = Map();
  String complexity;
  String day;
  String dateReadable;
  String startTime;
  String endTime;
  String icon;
  String language;
  String mainTag;
  List<DevFestMiniSpeaker>  speakers = List();
  List<String> tags = List();
  Map track = Map();

  DevFestActivity.generic(this.id, this.title, this.description, this.duration, this.complexity, this.day, this.dateReadable,
      this.startTime, this.endTime, this.icon, this.language, this.mainTag, this.tags, this.track);

  DevFestActivity(this.id, this.title, this.description, this.duration, this.complexity, this.day, this.dateReadable,
      this.startTime, this.endTime, this.icon, this.language, this.mainTag, this.speakers, this.tags, this.track);
}
