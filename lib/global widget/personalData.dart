import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/custom_text_field.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

Widget personaldata() {
  String? name;
  String? companyName;
  String? email;
  String? message;
  Widget personalDataDesktop(GlobalController controller) {
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
                        onChangedFunction: (value) {
                          name = value;
                        },
                      ),
                      CustoumTextField(
                        hintName: 'Enter Email',
                        obsecureText: false,
                        width: 20.w,
                        onChangedFunction: (value) {
                          email = value;
                        },
                      ),
                      CustoumTextField(
                        hintName: 'Company name',
                        obsecureText: false,
                        width: 20.w,
                        onChangedFunction: (value) {
                          companyName = value;
                        },
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
                        onChangedFunction: (value) {
                          message = value;
                        },
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        margin: EdgeInsets.only(top: 5.h),
                        child: ElevatedButton(
                          onPressed: () async {
                            // showLoadingDialog();
                            await controller.insertUser(
                              name: name ?? '',
                              email: email ?? '',
                              companyName: companyName ?? '',
                              message: message ?? '',
                            );
                            // hideLoadingDialog();
                          },
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

  Widget personalDataMobile(GlobalController controller) {
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
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 24, bottom: 24),
              child: Column(
                children: [
                  CustoumTextField(
                    hintName: 'Enter name',
                    obsecureText: false,
                    width: Get.width,
                    onChangedFunction: (value) {
                      name = value;
                    },
                  ),
                  CustoumTextField(
                    hintName: 'Enter Email',
                    obsecureText: false,
                    width: Get.width,

                    onChangedFunction: (value) {
                      email = value;
                    },
                  ),
                  CustoumTextField(
                    hintName: 'Company name',
                    obsecureText: false,
                    width: Get.width,

                    onChangedFunction: (value) {
                      companyName = value;
                    },
                  ),
                  CustoumTextField(
                    hintName: 'Messege',
                    obsecureText: false,
                    width: Get.width,

                    maxLines: 5,
                    onChangedFunction: (value) {
                      message = value;
                    },
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    margin: EdgeInsets.only(top: 5.h),
                    child: ElevatedButton(
                      onPressed: () async {
                        // showLoadingDialog();
                        await controller.insertUser(
                          name: name ?? '',
                          email: email ?? '',
                          companyName: companyName ?? '',
                          message: message ?? '',
                        );
                        // hideLoadingDialog();
                      },
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
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  return GetBuilder<GlobalController>(
    builder: (controller) {
      return ResponsiveLayout(
        mobile: personalDataMobile(controller),
        desktop: personalDataDesktop(controller),
      );
    },
  );
}
