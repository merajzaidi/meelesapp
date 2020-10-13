import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colorConstants.dart';
import '../components/userProfileSectionDrawer.dart';
import '../components/drawerInkwellButtons.dart';
import '../providers/auth.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kprimaryColor,
        child: ListView(
          children: [
            UserProfileSectionDrawer(),
            Center(
              child: DrawerButtons(
                buttonTitle: 'Home Page',
                buttonIcon: Icon(
                  Icons.home,
                  color: kwhiteAlternateColor,
                ),
              ),
            ),
            DrawerButtons(
              buttonTitle: "Register your Shop",
              buttonIcon: Icon(
                Icons.assignment,
                color: kwhiteAlternateColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: "Create weekly menu's",
              buttonIcon: Icon(
                Icons.assignment,
                color: kwhiteAlternateColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'About us',
              buttonIcon: Icon(
                Icons.business_center,
                color: kwhiteAlternateColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Feedback',
              buttonIcon: Icon(
                Icons.feedback,
                color: kwhiteAlternateColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
              buttonTitle: 'Contact us',
              buttonIcon: Icon(
                Icons.phone,
                color: kwhiteAlternateColor,
              ),
              onPressed: () {},
            ),
            DrawerButtons(
                buttonTitle: 'Logout',
                buttonIcon: Icon(
                  Icons.backspace,
                  color: kwhiteAlternateColor,
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  await Provider.of<Auth>(context, listen: false).authlogout();
                }),
          ],
        ),
      ),
    );
  }
}
