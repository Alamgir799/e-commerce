// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) {
                setState(() {
                  inputText = val;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
            SizedBox(height:20.h,),
            Expanded(
                child: Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .where("product-name", isEqualTo: inputText)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("something is rang"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading"),
                      );
                    }
                    return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(data["product-name"]),
                          leading: Image.network(data["img"][0]),
                        ),
                      );
                    }).toList());
                  }),
            ))
          ],
        ),
      )),
    );
  }
}
