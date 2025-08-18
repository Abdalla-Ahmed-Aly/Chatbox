import 'package:azlistview_plus/azlistview_plus.dart';

class ContactModel extends ISuspensionBean {
final String imagePath;
final String bio;
final String name;
final String tag;

ContactModel({required this.name,required this.bio,required this.imagePath}): tag = name[0].toUpperCase();
static List<ContactModel> contact=[
  ContactModel(name: "Marwan", bio: "Hi,i'm using chatbox", imagePath: "assets/images/model1.png"),
  ContactModel(name: "Ahmed", bio: "Hi,i'm using chatbox", imagePath: "assets/images/model1.png"),
  ContactModel(name: "bob", bio: "Hi,i'm using chatbox", imagePath: "assets/images/model1.png"),
  ContactModel(name: "مروان", bio: "Hi,i'm using chatbox", imagePath: "assets/images/model1.png"),
  ContactModel(name: "احمد", bio: "Hi,i'm using chatbox", imagePath: "assets/images/model1.png"),





];

  @override
  String getSuspensionTag() =>tag;



}