import 'package:chatbox/core/theme/app_theme.dart';
import 'package:chatbox/core/widget/custom_button.dart';
import 'package:chatbox/features/createGroup/presentation/screens/widget/AvatarforGroub.dart';
import 'package:chatbox/features/createGroup/presentation/screens/widget/groubAdminStyle.dart';
import 'package:chatbox/features/createGroup/presentation/screens/widget/selectGroup.dart';
import 'package:flutter/material.dart';

class CreateGroupscreen extends StatefulWidget {
  static const String routeName = '/CreateGroup';

  @override
  State<CreateGroupscreen> createState() => _CreateGroupscreenState();
}

class _CreateGroupscreenState extends State<CreateGroupscreen> {
  int? selectedIndex;

  final List<String> groups = ["Group work", "Team relationship"];
  List<bool> isAddList = List.generate(6, (_) => true);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: Text(
          'CreateGroup',
          style: textTheme.titleLarge!.copyWith(color: AppTheme.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Group Description',
              style: textTheme.titleLarge!.copyWith(color: AppTheme.gray),
            ),
            Text(
              'Make Group for Team Work',
              style: textTheme.displaySmall!.copyWith(color: AppTheme.black),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(groups.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SelectGroup(
                    text: groups[index],
                    isSelected: selectedIndex == index,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            if (selectedIndex != null) ...[
              Text(
                "You selected: ${groups[selectedIndex!]}",
                style: textTheme.titleMedium!.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 13),
            Text(
              'Group Admin',
              style: textTheme.titleLarge!.copyWith(color: AppTheme.gray),
            ),
            const SizedBox(height: 10),

            Groubadminstyle(Name: 'Abdoo'),
            const SizedBox(height: 13),
            Text(
              'Invited Members',
              style: textTheme.titleLarge!.copyWith(color: AppTheme.gray),
            ),
            const SizedBox(height: 13),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                itemCount: isAddList.length,
                itemBuilder: (context, index) {
                  return Avatarforgroub(
                    imagePath: 'assets/images/model1.png',
                    showAddButton: isAddList[index],
                    onTap: () {
                      isAddList[index] = !isAddList[index];
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Added"),

                          duration: Duration(seconds: 0),
                          backgroundColor: AppTheme.lightGreen,
                        ),
                      );
                    },
                    radius: 50,
                  );
                },
              ),
            ),
            CustomButton(
              onPressed: () {},
              text: 'Create',
              buttonColor: AppTheme.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}
