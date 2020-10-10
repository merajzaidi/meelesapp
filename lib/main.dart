import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/homeOverviewScreen.dart';
import './constants/colorConstants.dart';
import 'constants/textThemeConstants.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Meales',
            theme: ThemeData.light().copyWith(
              primaryColor: kprimaryColor,
              appBarTheme: AppBarTheme(
                  centerTitle: true, elevation: 3.0, textTheme: ktextTheme),
            ),
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
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return HomepageOverviewScreen();
                  }
                  return AuthScreen();
                }),
            routes: {}),
      ),
    );
  }
}
