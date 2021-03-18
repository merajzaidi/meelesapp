import 'package:Meeles_Partner/helpermethods/helpermethods.dart';
import 'package:Meeles_Partner/screens/loginscreen.dart';
import 'package:Meeles_Partner/screens/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:Meeles_Partner/providers/screen.dart';
import 'package:Meeles_Partner/screens/bookingdetails_screen.dart';
import 'package:Meeles_Partner/screens/contactus_screen.dart';
import 'package:Meeles_Partner/screens/menuview_screen.dart';
import 'package:Meeles_Partner/screens/updatemenu_screen.dart';
import 'package:Meeles_Partner/screens/weeklyMenusScreen.dart';
import 'package:provider/provider.dart';
import './screens/homeOverviewScreen.dart';
import './constants/colorConstants.dart';
import 'constants/textThemeConstants.dart';
import './providers/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/updatemenu_screen.dart';
import './providers/menu.dart';
import './screens/menuview_screen.dart';
import './screens/registerprofile_screen.dart';
import './screens/aboutus_screen.dart';

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
            theme: ThemeData.light().copyWith(
              primaryColor: kprimaryColor,
              appBarTheme: AppBarTheme(
                  centerTitle: true, elevation: 3.0, textTheme: ktextTheme),
            ),
            home: auth.isAuth ? auth.isregisteration ? HomepageOverviewScreen() : Profile() : LoginScreen(),
            routes: {
              Updatemenu.routeName: (ctx) => Updatemenu(),
              CardVariant.routeName: (ctx) => CardVariant(),
              HomepageOverviewScreen.routeName: (ctx) =>
                  HomepageOverviewScreen(),
              AboutUs.routeName: (ctx) => AboutUs(),
              ContactUs.routeName: (ctx) => ContactUs(),
              Profile.routeName: (ctx) => Profile(),
              WeeklyMenuOverviewScreen.routeName: (ctx) =>
                  WeeklyMenuOverviewScreen(),
              Bookingdetails.routeName: (ctx) => Bookingdetails(),
            }),
      ),
    );
  }
}
