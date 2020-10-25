import '../constants/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/screen.dart';

class NavigationBarBottom extends StatefulWidget {
  @override
  _NavigationBarBottomState createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: kwhiteAlternateColor,
      selectedItemColor: kprimaryColor,
      unselectedItemColor: Colors.black,
      elevation: 8.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text(
            "Menu's",
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text(
            'Bookings',
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text(
            'Profile',
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          ),
        ),
      ],
      onTap: (index) {
        Provider.of<Screen>(context, listen: false).getindex(index);
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
