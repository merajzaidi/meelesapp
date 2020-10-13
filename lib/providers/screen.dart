import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:meeles/screens/registerScreen.dart';
import 'package:meeles/screens/viewprofile_screen.dart';
import '../screens/weeklyMenusScreen.dart';
import '../screens/booking_screen.dart';

class Screen with ChangeNotifier {
  int index;
  String title;

  Future<void> getindex(int catchindex) {
    index = catchindex;
    print(index);
    return null;
  }

  Widget get page {
    if (index == 0)
      return Registration();
    else if (index == 1)
      return WeeklyMenuOverviewScreen();
    else if (index == 2)
      return BookingView();
    else
      return ProfileView();
  }
}
