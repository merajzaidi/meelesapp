import 'package:flutter/material.dart';
import 'package:Meeles_Partner/screens/contactus_screen.dart';
import 'package:provider/provider.dart';
import '../constants/colorConstants.dart';
import '../components/userProfileSectionDrawer.dart';
import '../components/drawerInkwellButtons.dart';
import '../providers/auth.dart';
import '../screens/aboutus_screen.dart';

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
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            DrawerButtons(
              buttonTitle: "Create weekly menu's",
              buttonIcon: Icon(
                Icons.assignment,
                color: kwhiteAlternateColor,
              ),
            ),
            DrawerButtons(
              buttonTitle: 'About us',
              buttonIcon: Icon(
                Icons.business_center,
                color: kwhiteAlternateColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
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
              onPressed: () {
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
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
