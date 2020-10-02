import 'package:flutter/material.dart';

class MessDetails {
  final String messName;
  final String messLocation;
  final DateTimeRange messTiming;
  final int messCapacitySeats;
  final bool openForWholeDay;
  final bool singleVariant;
  final bool monthlyPayVariant;
  final String messImageUrl;

  MessDetails(
      {@required this.messName,
      this.messLocation,
      this.messTiming,
      this.messCapacitySeats,
      this.openForWholeDay,
      this.singleVariant,
      this.monthlyPayVariant,
      this.messImageUrl});
}
