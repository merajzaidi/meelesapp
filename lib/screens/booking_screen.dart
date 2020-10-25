import 'package:flutter/material.dart';

class BookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'You will soon receive orders from here.',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
