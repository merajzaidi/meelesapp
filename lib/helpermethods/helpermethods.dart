import 'package:Meeles_Partner/models/messDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/globalvariables.dart';

class HelperMethod {

  Future currentMessinfo()async{
    print('Entered Method');
   DocumentSnapshot data = await obj.collection('Mess').doc(auth.currentUser.email).get().then((value) => value);
   selfdata = MessDetails.getdata(data);
   print(selfdata.mess_landmark);
  }
}