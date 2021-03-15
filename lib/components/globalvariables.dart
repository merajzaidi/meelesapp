import 'package:Meeles_Partner/models/messDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

MessDetails selfdata;
FirebaseFirestore obj = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;