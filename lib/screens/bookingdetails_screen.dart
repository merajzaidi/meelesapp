import 'package:flutter/material.dart';

class Bookingdetails extends StatelessWidget {
  static const routeName = '/bookingdetails';
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
