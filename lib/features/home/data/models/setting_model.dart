class SettingModel {
  final String iconPath;
  final String mainTeat;
  final String? subText;
  SettingModel({required this.iconPath,required this.mainTeat,required this.subText});
static List<SettingModel>setting=[
  SettingModel(iconPath: "assets/svg/account.svg", mainTeat: "Account", subText:"Privacy, security, change number"),
  SettingModel(iconPath: "assets/svg/chat.svg", mainTeat: "Chat", subText: "Chat history,theme,wallpapers"),
  SettingModel(iconPath: "assets/svg/notificationSetting.svg", mainTeat: "Notifications", subText: "Messages, group and others"),
  SettingModel(iconPath: "assets/svg/help.svg", mainTeat: "Help", subText: "Help center,contact us, privacy policy"),
  SettingModel(iconPath: "assets/svg/data.svg", mainTeat: "Storage and data", subText: "Network usage, stogare usage"),
  SettingModel(iconPath: "assets/svg/inviteFriend.svg", mainTeat: "Invite a friend", subText: null),
  ];


}