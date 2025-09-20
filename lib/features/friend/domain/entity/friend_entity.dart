import 'package:azlistview_plus/azlistview_plus.dart';



class FriendEntity  extends  ISuspensionBean  {
  final String profilePic;
  final String bio;
  final String firstLetter;
  final String username;
  final String status;
  FriendEntity({required this.username,required this.bio,required this.firstLetter,required this.profilePic,required this.status});

  @override
 String getSuspensionTag()=>firstLetter;








}