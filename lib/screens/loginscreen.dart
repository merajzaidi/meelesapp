import 'package:Meeles_Partner/providers/auth.dart';
import 'package:Meeles_Partner/screens/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.dstATop),
            image: AssetImage('images/thali.jpg'), fit: BoxFit.cover),),
    child: Center(
      child: Form(
        key: _key,
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontFamily: 'Lato',color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),),
            SizedBox(height: 12),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.number,
              maxLength: 10,
              
              decoration: InputDecoration(
                labelText: 'Phone No.',
                labelStyle: TextStyle(fontFamily: 'Lato', color: Colors.black,),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)), borderSide: BorderSide(color: Colors.white))
              ),
            ),
            //SizedBox(height:6),
            ElevatedButton(
              onPressed: (){
                print(phone.text);
                Provider.of<Auth>(context,listen: false).messphone(phone.text);
                Navigator.of(context).push(_createRoute());
              },
             child: Text('Send OTP'), style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor,),),
          ],
        ),
      ),
      ),
          ),
      );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => OTPScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}