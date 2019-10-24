import 'package:devfest_levante_2019/model/DevFestUser.dart';
import 'package:devfest_levante_2019/repository/ActivitiesRepository.dart';
import 'package:devfest_levante_2019/model/DevFestActivity.dart';
import 'package:devfest_levante_2019/repository/SpeakersRepository.dart';
import 'package:devfest_levante_2019/repository/UserRepository.dart';
import 'package:devfest_levante_2019/ui/schedule/SpeakersChimpList.dart';
import 'package:devfest_levante_2019/ui/schedule/TalkPage.dart';
import 'package:devfest_levante_2019/utils/ColorUtils.dart';
import 'package:devfest_levante_2019/utils/DateTimeHelper.dart';
import 'package:devfest_levante_2019/utils/LoadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

SpeakersRepository speakersRepo;

class FavouriteSchedulePage extends StatelessWidget {
  final String userId;

  FavouriteSchedulePage(this.userId, repo) {
    speakersRepo = repo;
  }

  UserRepository userRepo;

  @override
  Widget build(BuildContext context) {
    userRepo = UserRepository(userId);

    return StreamBuilder(
      stream: userRepo.getUser(),
      builder: (context, userData) {
        if (userData.hasData) {
          DevFestUser user = userData.data;

          return StreamBuilder(
              stream: ActivitiesRepository.getFavouriteActivities(
                  user.bookmarks),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container(child: Center(child: Text("No bookmarks added! :)"),),);

                if (snapshot.data.length == 0) return Container(
                  child: Center(
                    child: Text("No bookmarks added! :)"),
                  ),
                );

                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: const EdgeInsets.only(top: 10.0),
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data[index]),
                  ),
                );
              });
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  _buildListItem(BuildContext context, activity) {
    return ActivityTile(activity);
  }
}

class ActivityTile extends StatelessWidget {
  const ActivityTile(this.activity);

  final DevFestActivity activity;
/*

  Elements that can be generated:

  TitleWidget(activity)
  Show activity title;
  Argument must not be null;

  DescriptionWidget(activity)
  Show activity description. Returns an empty container if description is null;


  StartTimeWidget(activity)
  Show activity's start time.
  Argument must not be null;

  SpeakerChipWidget(activity)
  Show a chip with Speaker's avatar and name.
  Returns an empty container if activity doesn't have a speaker (generic activity);

  ActivityChipWidget(activity)
  Show a chip with Activity type (Talk|Workshop)
  Returns an empty container in case of generic activity;

*/

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openTalkPage(context, activity),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DateTimeWidget(activity),
                ActivityChipWidget(activity),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TitleWidget(activity),
                    DescriptionWidget(activity),
                    SpeakerChipWidget(activity),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openTalkPage(BuildContext context, DevFestActivity talk) {

    FirebaseAuth.instance.currentUser().then((user) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TalkPage(talk, user.uid, speakersRepo)));
    });
  }
}

class SpeakerChipWidget extends GenericScheduleWidget {
  SpeakerChipWidget(DevFestActivity activity) : super(activity);

  @override
  Widget build(BuildContext context) {
    // Only shows my avatar for now \o/
    // Even if this is really cool, we need to join talk with speakers. Later.
    // TODO query Firestore with speakerID

    return SpeakersChimpList(speakersRepo.getSpeakersById(activity.speakers),
        activity.id);
  }
}

class TitleWidget extends GenericScheduleWidget {
  TitleWidget(DevFestActivity activity) : super(activity);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "anim_activity_${activity.id}",
      child: Material(
        color: Colors.transparent,
        child: Text(
          activity.title,
          textScaleFactor: 1.4,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DescriptionWidget extends GenericScheduleWidget {
  DescriptionWidget(DevFestActivity activity) : super(activity);

  @override
  Widget build(BuildContext context) {
    return ((activity.description != null) ? Text(activity.description) : Container());
  }
}

class DateTimeWidget extends GenericScheduleWidget {
  DateTimeWidget(DevFestActivity activity) : super(activity);

  @override
  Widget build(BuildContext context) {
    var color = ColorUtils.hexToColor("#676767");

    // if (activity.type == "talk") {
    //  color = Colors.blueAccent;
    // } else if (activity.type == "workshop") {
    //   color = Colors.deepOrangeAccent;
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(activity.dateReadable,
            textScaleFactor: 1.2,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(activity.startTime,
            textScaleFactor: 1.8,
            style: TextStyle(color: color, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

class ActivityChipWidget extends GenericScheduleWidget {
  ActivityChipWidget(DevFestActivity activity) : super(activity);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Text(
            "TALK",
            style: TextStyle(
                color: ColorUtils.hexToColor("#676767"), fontWeight: FontWeight.w300),
            textScaleFactor: 0.8,
          ),
        ),
      ],
    );
  }
}

abstract class GenericScheduleWidget extends StatelessWidget {
  final DevFestActivity activity;
  const GenericScheduleWidget(this.activity);
}