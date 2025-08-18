import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/contact_model.dart';
import 'contact_info_widget.dart';

class AlphContactList extends StatefulWidget {
  const AlphContactList({super.key});

  @override
  State<AlphContactList> createState() => _AlphContactListState();

}

class _AlphContactListState extends State<AlphContactList> {
  @override
  void initState() {
   SuspensionUtil.sortListBySuspensionTag(ContactModel.contact);
   SuspensionUtil.setShowSuspensionStatus(ContactModel.contact);
   setState(() {

   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AzListView(
      indexBarWidth: 0,
      indexBarHeight: 0,
      itemBuilder: (context, index) {

        final offStage=!ContactModel.contact[index].isShowSuspension;
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: offStage,
            child: Padding(
              padding: const EdgeInsets.only(top: 30,left: 24,bottom: 5),
              child: Text(ContactModel.contact[index].getSuspensionTag(),style:Theme.of(context).textTheme.titleLarge!.copyWith(color: AppTheme.black),),
            ),
          ),

          ContactInfoWidget(contact: ContactModel.contact[index]),
        ],
      );
      },
      itemCount:ContactModel.contact.length,
      data:ContactModel.contact,




    );
  }
}
