import 'package:Meeles_Partner/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  var args;
  //OTPScreen(this.args);
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(15.0),
    );
  }  
  final _key = GlobalKey<FormFieldState>();
  final _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String id;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //var args = ModalRoute.of(context).settings.arguments;
    args = Provider.of<Auth>(context).messmobile;
    print(args);
      void sentotp(_phonenumber)async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phonenumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print('verification');
          await Provider.of<Auth>(context, listen: false).phonelogin(credential);
          Navigator.of(context).pop();
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Invalid Phone Number'),
                backgroundColor: Colors.red,
              ),
            );
            //Navigator.of(context).pop();
          }
        },
        codeSent: (String verificationId, int resendToken) async {
          print('entered');
          
            id = verificationId;
          
          print(id);
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Timeout'),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.of(context).pop();
        },
      );
  }

  sentotp(args);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(child: Text('Back'), onPressed: (){
        Navigator.pop(context);
        },),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.all(15),
          height: height,
          width: width,
          decoration: BoxDecoration(image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.dstATop),
            image: AssetImage('images/thal2.jpg'), fit: BoxFit.cover),),
          child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text('Enter OTP', style: TextStyle(fontFamily: 'Lato',color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900),),
                SizedBox(height:6),
                Text('We have sent an OTP on +91${args}', style: TextStyle(fontFamily: 'Lato',color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),),
                SizedBox(
                    height: 12,
                  ),
                  PinPut(
                    key: _key,
                    fieldsCount: 6,
                    validator: (val) {
                      if (val.length != 6) return 'Enter The OTP';
                    },
                    textStyle: TextStyle(color: Colors.black),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),

            ElevatedButton(
              onPressed: ()async{
                
                    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                      verificationId: id,
                      smsCode: _pinPutController.text,
                    );
                    print(phoneAuthCredential);
                    await Provider.of<Auth>(context, listen: false)
                        .phonelogin(phoneAuthCredential);
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
              },
             child: Text('Verify'), style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor,),),
              ],
            ),
          ),
          ),
      ),
    );
  }
}