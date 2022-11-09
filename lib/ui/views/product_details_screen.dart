// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/const/app_string.dart';
import 'package:ecommerce/ui/widgets/custome_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  var _product;
  ProductDetailsScreen(this._product);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var _dotPosition = 0;
  Future addToCard() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => print("Added to cart"));
  }

  Future addToFavourite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30.w,
                        color: AppColors.deep_orange,
                      )),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users-favourite-items")
                        .doc(FirebaseAuth.instance.currentUser!.email)
                        .collection("items")
                        .where("name",
                            isEqualTo: widget._product["product-name"])
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("");
                      }
                      return IconButton(
                          onPressed: () => snapshot.data.docs.length == 0
                              ? addToFavourite()
                              : print("already added"),
                          icon: snapshot.data.docs.length == 0
                              ? Icon(
                                  Icons.favorite_border_outlined,
                                  size: 30.w,
                                  color: AppColors.deep_orange,
                                )
                              : Icon(
                                  Icons.favorite,
                                  size: 30.w,
                                  color: AppColors.deep_orange,
                                ));
                    },
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 2.0,
                child: CarouselSlider(
                    items: widget._product["product-img"]
                        .map<Widget>((item) => Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.fill)),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (val, carouselPageChangedReason) {
                          setState(() {
                            _dotPosition = val;
                          });
                        })),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: DotsIndicator(
                  dotsCount:
                      widget._product.length == 0 ? 1 : widget._product.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColors.deep_orange,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget._product["product-name"],
                style: TextStyle(fontSize: 30.sp, color: AppColors.deep_orange),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget._product["product-description"],
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget._product["product-price"].toString(),
                style: TextStyle(fontSize: 30.sp, color: AppColors.deep_orange),
              ),
              SizedBox(
                height: 30.h,
              ),
              customButton(AppStrings.addToCard, () => addToCard()),
            ],
          ),
        ),
      )),
    );
  }
}
