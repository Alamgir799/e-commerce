// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/const/app_string.dart';
import 'package:ecommerce/ui/widgets/custome_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  TextEditingController? _nameController;

  TextEditingController? _phoneController;

  TextEditingController? _dobController;

  TextEditingController? _genderController;

  TextEditingController? _ageController;

  setDataToTextField(data) {
    return Column(
      children: [
        TextFormField(
          controller: _nameController =
              TextEditingController(text: data["name"]),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          controller: _phoneController =
              TextEditingController(text: data["phone"]),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          controller: _dobController =
              TextEditingController(text: data["date"]),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          controller: _genderController =
              TextEditingController(text: data["gander"]),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          controller: _ageController = TextEditingController(text: data["age"]),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        customButton(AppStrings.upDate, () => upDateData())
      ],
    );
  }

  upDateData() {
    CollectionReference _collectionref =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionref.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "phone": _phoneController!.text,
      "date": _dobController!.text,
      "gander": _genderController!.text,
      "age": _ageController!.text,
    }).then((value) => print("Update Successfull"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return setDataToTextField(data);
          },
        ),
      ),
    ));
  }
}
