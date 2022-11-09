// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-cart-items")
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
                 else if (snapshot.hasError) {
                    return Center(
                      child: Text("something is rong"),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            leading: Text(_documentSnapshot["name"]),
                            title: Text(
                              "\$ ${_documentSnapshot["price"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                  color: AppColors.deep_orange),
                            ),
                            trailing: GestureDetector(
                              child: CircleAvatar(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove,
                                      size: 20.w,
                                    )),
                              ),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection("users-cart-items")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection("items")
                                    .doc(_documentSnapshot.id)
                                    .delete();
                              },
                            ),
                          ),
                        );
                      });
                }))
    );
  }
}
