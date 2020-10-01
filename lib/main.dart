import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/homeOverviewScreen.dart';
import './constants/colorConstants.dart';
import 'constants/textThemeConstants.dart';
import './screens/loginScreen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meales',
          theme: ThemeData.light().copyWith(
            primaryColor: kprimaryColor,
            appBarTheme: AppBarTheme(
                centerTitle: true, elevation: 3.0, textTheme: ktextTheme),
          ),
          home: AuthScreen(),
          routes: {}),
    );
  }
}
