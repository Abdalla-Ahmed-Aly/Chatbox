import 'package:flutter/material.dart';

import '../../data/models/contact_model.dart';
import 'contact_info_widget.dart';

class NotAlphContactList extends StatelessWidget {
  const NotAlphContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => ContactInfoWidget(contact: ContactModel.contact[index]),
      itemCount:ContactModel.contact.length,
      separatorBuilder: (context, index) => SizedBox(height: 5,),

    );
  }
}
