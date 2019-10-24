import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:devfest_levante_2019/repository/SpeakersRepository.dart';
import 'package:devfest_levante_2019/utils/ColorUtils.dart';
import 'package:devfest_levante_2019/utils/DevFestTabTextTheme.dart';
import 'package:devfest_levante_2019/ui/schedule/SingleSchedulePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SchedulePage extends StatelessWidget {
  final SpeakersRepository speakersRepo;

  SchedulePage(this.speakersRepo);

  @override
  Widget build(BuildContext context) {
    var day = DateTime.now().day;
    var index = day - 2;

    return DefaultTabController(
      initialIndex: index > 0 && index < 2 ? index : 0,
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: ColorUtils.hexToColor("#676767"),
            indicator: BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Colors.blueAccent,
              tabBarIndicatorSize: TabBarIndicatorSize.tab
            ),
            isScrollable: true,
            tabs: [
              Tab(child: DevFestTabTextTheme("Nov 2")),
              Tab(child: DevFestTabTextTheme("Nov 3")),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                SingleSchedulePage(2, speakersRepo),
                SingleSchedulePage(3, speakersRepo),
              ],
            ),
          )
        ],
      ),
    );
  }
}
