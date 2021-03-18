import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MessDetails {
  String shopName;
  String mess_address;
   String mess_landmark;
   String mess_fssai;
   String mess_gst;
   String mess_servicetype;
   String lunch_begin;
   String lunch_end;
   String dinner_begin;
   String dinner_end;
   GeoPoint coordinates;
   String note1;
   String note2;
   String note3;
   String note4;
   String capacity;
   bool openForWholeDay;
   bool monthlyPayVariant;
   String url;
   String owner_name;
   String owner_address;
   String owner_pincode;
   String owner_adharcard;
   String owner_mobile;

  MessDetails({
      @required this.shopName,
      @required this.mess_address,
      @required this.capacity,
      @required this.openForWholeDay,
      @required this.monthlyPayVariant,
      @required this.url,
      @required this.coordinates,
      @required this.dinner_begin,
      @required this.dinner_end,
      @required this.lunch_begin,
      @required this.lunch_end,
      @required this.mess_fssai,
      @required this.mess_gst,
      @required this.mess_landmark,
      @required this.mess_servicetype,
      @required this.note1,
      @required this.note2,
      @required this.note3,
      @required this.note4,
      @required this.owner_address,
      @required this.owner_adharcard,
      @required this.owner_mobile,
      @required this.owner_name,
      @required this.owner_pincode,
  });

  MessDetails.getdata(DocumentSnapshot snapshot){
    var data = snapshot.data();
    capacity = data['Capacity'];
    owner_name = data['Owner Name'];
    owner_address = data['Address'];
    owner_pincode = data['Pincode'];
    owner_mobile = data['Phone No.'];
    owner_adharcard = data['Adhar Card'];
    mess_landmark = data['Landmark'];
    shopName = data['Shop Name'];
    mess_address = data['Address'];
    mess_fssai = data['FSSAI NO'];
    mess_gst = data['GST NO'];
    mess_servicetype = data['Service Type'];
    coordinates = data['coordinates'];
    openForWholeDay = data['Open Whole Day'];
    monthlyPayVariant = data['Monthly Subscription'];
    lunch_begin = data['Lunch Begining'];
    lunch_end = data['Lunch End'];
    dinner_begin = data['Dinner Starting'];
    dinner_end = data['Dinner End'];
    note1 = data['note1'];
    note2 = data['note2'];
    note3 = data['note3'];
    note4 = data['note4'];
    url = data['url'];
  }
}
