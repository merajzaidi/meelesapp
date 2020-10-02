import 'package:flutter/material.dart';

class MessDetails {
  final String messDetailsId;
  final String messName;
  final String messLocation;
  final DateTimeRange messTiming;
  final int messCapacitySeats;
  final bool openForWholeDay;
  final bool singleVariantThali;
  final bool monthlyPayVariant;
  final String messImageUrl;

  MessDetails(
      {@required this.messDetailsId,
      @required this.messName,
      @required this.messLocation,
      @required this.messTiming,
      @required this.messCapacitySeats,
      @required this.openForWholeDay,
      @required this.singleVariantThali,
      @required this.monthlyPayVariant,
      @required this.messImageUrl});
}
