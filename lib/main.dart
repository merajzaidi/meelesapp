import 'package:flutter/material.dart';
import 'package:meeles/providers/screen.dart';
import 'package:meeles/screens/registerScreen.dart';
import 'package:provider/provider.dart';
import './screens/homeOverviewScreen.dart';
import './constants/colorConstants.dart';
import 'constants/textThemeConstants.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './providers/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider.value(
    //       value: Auth(),
    //     ),
    //   ],
    // child: Consumer<Auth>(
    //   builder: (ctx, auth, _) => MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'Meales',
    //       theme: ThemeData.light().copyWith(
    //         primaryColor: kprimaryColor,
    //         appBarTheme: AppBarTheme(
    //             centerTitle: true, elevation: 3.0, textTheme: ktextTheme),
    //       ),
    // home: auth.isAuth
    //     ? HomepageOverviewScreen()
    //     : FutureBuilder(
    //         future: auth.tryAutoLogin(),
    //         builder: (ctx, authResultSnapshot) =>
    //             authResultSnapshot.connectionState ==
    //                     ConnectionState.waiting
    //                 ? SplashScreen()
    //                 : AuthScreen(),
    //       ),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(create: (_) => Screen())
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            title: 'Meeles',
            theme: ThemeData.light().copyWith(
              primaryColor: kprimaryColor,
              appBarTheme: AppBarTheme(
                  centerTitle: true, elevation: 3.0, textTheme: ktextTheme),
            ),
            // home: StreamBuilder(
            //     stream: FirebaseAuth.instance.authStateChanges(),
            //     builder: (ctx, userSnapshot) {
            //       if (userSnapshot.hasData) {
            //         return Registration();
            //       }
            //       return AuthScreen();
            home: auth.isAuth ? Registration() : AuthScreen(),
            routes: {}),
      ),
    );
  }
}
