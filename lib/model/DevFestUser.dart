class DevFestUser {
  String userId;
  String email;
  String displayName;
  String notificationToken;
  String photoURL;
  List<dynamic> bookmarks = List<dynamic>();

  DevFestUser();
  DevFestUser.create(this.userId, this.email, this.displayName,
      this.notificationToken, this.photoURL, this.bookmarks);
}
