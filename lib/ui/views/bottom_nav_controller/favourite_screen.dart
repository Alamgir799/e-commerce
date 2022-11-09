// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoutiteScreen extends StatelessWidget {
  const FavoutiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favourite-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
               else if(snapshot.hasError) {
                  return Center(
                    child: Text("something is rong"),
                  );
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[index];
                      return Card(
                        elevation: 10,
                        child:
                            Image.network(_documentSnapshot["images"][index]),
                      );
                    });
              })),
    );
  }
}
