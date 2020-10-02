import 'package:flutter/material.dart';

class WeeklyMenu {
  final String dayName;
  final Color dayBackgroundColor;
  final String dayId;
  final List items;
  final Map dayWithItemsMap;
  WeeklyMenu(
      {@required this.dayName,
      @required this.dayBackgroundColor,
      @required this.dayId,
      @required this.items,
      @required this.dayWithItemsMap});
}
