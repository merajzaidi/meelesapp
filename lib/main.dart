import 'package:flutter/material.dart';
import 'package:meeles/providers/screen.dart';
import 'package:meeles/screens/menuview_screen.dart';
import 'package:meeles/screens/updatemenu_screen.dart';
import 'package:provider/provider.dart';
import './screens/homeOverviewScreen.dart';
import './constants/colorConstants.dart';
import 'constants/textThemeConstants.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/updatemenu_screen.dart';
import './providers/menu.dart';
import './screens/menuview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(The getter 'user' was called on null.
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
        ChangeNotifierProvider(
          create: (_) => Screen(),
        ),
        ChangeNotifierProvider(
          create: (_) => Menu(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            //title: 'Meeles',
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
            home: auth.isAuth ? HomepageOverviewScreen() : AuthScreen(),
            routes: {
              Updatemenu.routeName: (ctx) => Updatemenu(),
              CardVariant.routeName: (ctx) => CardVariant(),
            }),
      ),
    );
  }
}
