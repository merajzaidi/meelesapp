import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/colorConstants.dart';

class UserProfileSectionDrawer extends StatelessWidget {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        user.displayName,
        style: const TextStyle(
            color: Color(0xff213e3b),
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500),
      ),
      accountEmail: Text(
        user.phoneNumber,
        style: const TextStyle(
            color: Color(0xff213e3b),
            fontSize: 14.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w300),
      ),
      currentAccountPicture: GestureDetector(
        onTap: () {
          print('pressed');
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg',
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: kwhiteAlternateColor,
      ),
    );
  }
}
