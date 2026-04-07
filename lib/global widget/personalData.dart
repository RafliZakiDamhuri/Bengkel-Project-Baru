import 'package:flutter/material.dart';
import 'package:project/custom_text_field.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

Widget personaldata() {
  return Container(
    width: double.infinity,
    color: kBlueColor,

    child: Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            'Place Your Inquiry Here',
            style: whiteTextStyle.copyWith(fontSize: 28, fontWeight: bold),
          ),
        ),
        SizedBox(height: 3.h),
        Container(
          width: 65.w,

          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 24, bottom: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustoumTextField(
                      hintName: 'Enter name',
                      obsecureText: false,
                      width: 20.w,
                    ),
                    CustoumTextField(
                      hintName: 'Enter Email',
                      obsecureText: false,
                      width: 20.w,
                    ),
                    CustoumTextField(
                      hintName: 'Company name',
                      obsecureText: false,
                      width: 20.w,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustoumTextField(
                      hintName: 'Messege',
                      obsecureText: false,
                      width: 50.w,
                      maxLines: 5,
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      margin: EdgeInsets.only(top: 5.h),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "SUBMIT",
                          style: whiteTextStyle.copyWith(fontWeight: bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
