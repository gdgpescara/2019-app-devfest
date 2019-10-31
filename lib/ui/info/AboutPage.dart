import 'package:devfest_levante_2019/utils/UrlHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Center(child: Text("DevFest Pescara 2019 Official App", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Center(child: Text("Made with ♥ in Flutter by")),
        ),
        Center(child: Text("Palateam", style: TextStyle(fontSize: 20.0),)),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(child: PersonWidget("The\nPenguin", "https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-1/c0.0.320.320a/p320x320/18301112_10211414982122553_5848306714782759341_n.jpg?_nc_cat=102&_nc_oc=AQkORAZ3YsybJEoRg_JTNvAoZ19GqIpxRIka2jx5cstqUSUw9FXd-9yPeAQJGW_Ucf4&_nc_ht=scontent-fco1-1.xx&oh=3dbe27f7d2dc3ed9869f54648d2f0b75&oe=5E209E90")),
              Expanded(child: PersonWidget("The\nPogbo", "https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-1/p320x320/10590481_10202640821928821_6101896505306413566_n.jpg?_nc_cat=106&_nc_oc=AQktCsqB58CZ1gvaEcCiQynO7m0AJUyRVgZ8n9-adWl_lCZWKPhSS8zkezgTwoplNU4&_nc_ht=scontent-fco1-1.xx&oh=1434362b06823a9501224050ef1fc354&oe=5E56BD9B")),
              Expanded(child: PersonWidget("The\nBuddy", "https://media.licdn.com/dms/image/C4D03AQFmEH-jr8nRYA/profile-displayphoto-shrink_200_200/0?e=1577923200&v=beta&t=sgUqoeBD9mkCWTWQVqQ6GQL-JWYFkwLGHK28Nkor8rE")),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 32.0),
        //   child: Column(
        //     children: <Widget>[
        //       Text("with the help of some friends at"),
        //       Text("GDG Pescara", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        //       Padding(
        //         padding: const EdgeInsets.only(top: 8.0),
        //         child: PersonWidget("The\nBerrick", "https://media.licdn.com/dms/image/C5603AQHwO78I_1dy6A/profile-displayphoto-shrink_200_200/0?e=1567036800&v=beta&t=lTqUX0uih45-1gllEmbzyjTr36BeVF558gDM18NGz1Q"),
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Row(
            children: <Widget>[
              Expanded(child: PersonWidget("The\nBerrick", "https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-1/c0.0.320.320a/p320x320/1377375_10200671646622721_1425304864_n.jpg?_nc_cat=110&_nc_oc=AQmUoFOxdlCNjJzYZNOT-PDtEYhrqy6qJ4gApvwA9sP6gBDhm-1xswx_FkKlHhsGYiw&_nc_ht=scontent-fco1-1.xx&oh=37c218e9db91bcb5cd4f9d8766f8981c&oe=5E4F1ABC")),
              Expanded(child: PersonWidget("The\nPresident", "https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-1/c0.5.621.621a/s320x320/1043873_551352078260437_934602176_n.jpg?_nc_cat=109&_nc_oc=AQnDgmwb_UszFSlHG3bBM5uJuI6J0surkZrtAfBUegoFwyQMsJdm2zmIeMtHO_APkPs&_nc_ht=scontent-fco1-1.xx&oh=e0a04f8f4a82be2b4cbd607dc105eb38&oe=5E22A1BC")),
              Expanded(child: PersonWidget("The\nUncle", "https://scontent-fco1-1.xx.fbcdn.net/v/t1.0-1/p320x320/40213610_10156212308553110_3208687517570170880_n.jpg?_nc_cat=110&_nc_oc=AQnqDpFG5X_GYi6MskaIOp52VIymgSWbPMsHbxcqt_qQ76iaOekdqVwqjPkmo7sgKOo&_nc_ht=scontent-fco1-1.xx&oh=be4c51a5484af79cd97966cb052758d9&oe=5E4C0B05")),
            ],
          ),
        ),
        ListTile(
          onTap: () => UrlHelper.launchURL("https://devfest.gdgpescara.it//faq/"),
          title: Text("FAQ", style: TextStyle(color: Colors.blueAccent),),
          subtitle: Text("Find more about DevFest Levante"),
        ),
        ListTile(
          onTap: () => UrlHelper.launchURL("https://github.com/gdgpescara/2019-app-devfest"),
          title: Text("Source Code", style: TextStyle(color: Colors.blueAccent),),
          subtitle: Text("Available on GitHub"),
        ),
        ListTile(
          onTap: () =>
              showLicensePage(
                  context: context,
                  applicationName: "DevFest Pescara 2019",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "Copyright 2019 © Palateam"),
          title: Text("Open Source Licences", style: TextStyle(color: Colors.blueAccent),),
        ),
        ListTile(
          onTap: () => UrlHelper.launchURL("https://devfest.gdgpescara.it/"),
          title: Text("Official Website", style: TextStyle(color: Colors.blueAccent),),
        ),
        ListTile(
          onTap: () => UrlHelper.launchURL("https://www.facebook.com/gdgpescara/"),
          title: Text("Contact us", style: TextStyle(color: Colors.blueAccent),),
        ),
      ],
    );
  }

  void showLicensePage({
    @required BuildContext context,
    String applicationName,
    String applicationVersion,
    Widget applicationIcon,
    String applicationLegalese
  }) {
    assert(context != null);
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) => LicensePage(
            applicationName: applicationName,
            applicationVersion: applicationVersion,
            applicationLegalese: applicationLegalese
        )
    ));
  }
}

class PersonWidget extends StatelessWidget {
  final String url;
  final String desc;

  const PersonWidget(this.desc, this.url);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(
            backgroundImage: NetworkImage(url),
        radius: 50.0,),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(desc, textAlign: TextAlign.center),
        ),
      ],
    );
  }

}