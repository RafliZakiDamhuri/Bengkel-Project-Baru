import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/contactUsController.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/custom_text_field.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/customDropDown.dart';
import 'package:project/global%20widget/globalLoadingWidget.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

Widget personaldataContactUs() {
  String? name;
  String? companyName;
  String? email;
  String? message;
  String? position;
  String? phoneNumber;
  var globalController = Get.find<GlobalController>();

  Widget textWithIcon({required IconData iconData, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, size: 18),
        const SizedBox(width: 6),

        Expanded(child: Text(text, style: blackTextStyle, softWrap: true)),
      ],
    );
  }

  Widget cardContact({
    String? name,
    String? phoneNumber,
    String? email,
    String? image,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: image ?? '-',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ?? '-'),
                const SizedBox(height: 10),
                textWithIcon(iconData: Icons.phone, text: '+$phoneNumber'),
                const SizedBox(height: 10),
                textWithIcon(iconData: Icons.mail_outline, text: email ?? '-'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardContactMobile({
    String? name,
    String? phoneNumber,
    String? email,
    String? image,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: image ?? '',
              width: 55,
              height: 55,
              fit: BoxFit.cover,
              placeholder: (_, __) => const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (_, __, ___) => const Icon(Icons.person, size: 55),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            name ?? '-',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.phone, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '+${phoneNumber ?? '-'}',
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(Icons.mail_outline, size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  email ?? '-',
                  style: const TextStyle(fontSize: 11),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget personalDataDesktop(Contactuscontroller controller) {
    return Container(
      width: double.infinity,
      color: kBlueColor,

      child: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Tell Us About Your Requirements',
              style: whiteTextStyle.copyWith(fontSize: 28, fontWeight: bold),
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            width: 70.w,

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
                        hintName: 'Enter your name',
                        controller: controller.nameController,
                        obsecureText: false,
                        width: 20.w,
                        onChangedFunction: (value) {
                          name = value;
                          print('name textfield : $name');
                        },
                      ),
                      CustoumTextField(
                        hintName: 'Company name',
                        obsecureText: false,
                        controller: controller.companyController,

                        width: 20.w,
                        onChangedFunction: (value) {
                          companyName = value;
                          print('companyName textfield : $companyName');
                        },
                      ),
                      CustoumTextField(
                        hintName: 'Position',
                        controller: controller.positionController,

                        obsecureText: false,
                        width: 20.w,
                        onChangedFunction: (value) {
                          position = value;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustoumTextField(
                        hintName: 'Enter you email',
                        controller: controller.emailController,

                        obsecureText: false,
                        width: 20.w,
                        onChangedFunction: (value) {
                          email = value;
                        },
                      ),
                      CustoumTextField(
                        hintName: 'Phone Number',
                        controller: controller.phoneController,

                        obsecureText: false,
                        width: 20.w,
                        onChangedFunction: (value) {
                          phoneNumber = value;
                          print('phoneNumber textfield : $phoneNumber');
                        },
                      ),

                      CustomDropdown(
                        hintName: 'Inquiry Type',
                        width: 20.w,

                        value: controller.selectedInquiryType,
                        items: controller.inquiryTypeModel,
                        labelBuilder: (item) => item?.inquiryType ?? '',
                        onChanged: (val) {
                          controller.setSelectedInquiryType(val ?? '-');
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
                        controller: controller.messageController,
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
                            print('email : ${controller.emailController.text}');
                            print('name : ${controller.nameController.text}');
                            print('position : $position');
                            print('message : $message');
                            print('phoneNumber : $phoneNumber');
                            print('companyName: $companyName');

                            await Get.find<GlobalController>().insertUser(
                              name: controller.nameController.text,
                              email: controller.emailController.text,
                              companyName: controller.companyController.text,
                              message: controller.messageController.text,
                              position: controller.positionController.text,
                              phoneNumber: controller.phoneController.text,
                              inquiryType: controller.selectedInquiryType,
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
          SizedBox(height: 60),

          Center(
            child: SizedBox(
              width: 70.w, // sama dengan form
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.contactModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 140,
                ),
                itemBuilder: (_, index) {
                  var data = controller.contactModel[index];
                  return GestureDetector(
                    onTap: () {
                      globalController.openWhatsApp(
                        data.phoneNumber ?? '',
                        'Halo Saya Ingin Booking Service Schedule',
                      );
                    },
                    child: cardContact(
                      name: data.name,
                      phoneNumber: data.phoneNumber,
                      email: data.email,
                      image: data.image,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget personalDataMobile(Contactuscontroller controller) {
    return Container(
      width: double.infinity,
      color: kBlueColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tell Us About Your Requirements',
            textAlign: TextAlign.center,
            style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: bold),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                CustoumTextField(
                  hintName: 'Enter your name',
                  controller: controller.nameController,
                  obsecureText: false,
                  width: double.infinity,
                  onChangedFunction: (v) => name = v,
                ),

                const SizedBox(height: 16),

                CustoumTextField(
                  hintName: 'Enter your email',
                  controller: controller.emailController,
                  obsecureText: false,
                  width: double.infinity,
                  onChangedFunction: (v) => email = v,
                ),

                const SizedBox(height: 16),

                CustoumTextField(
                  hintName: 'Company name',
                  controller: controller.companyController,
                  obsecureText: false,
                  width: double.infinity,
                  onChangedFunction: (v) => companyName = v,
                ),

                const SizedBox(height: 16),

                CustoumTextField(
                  hintName: 'Phone Number',
                  controller: controller.phoneController,
                  obsecureText: false,
                  width: double.infinity,
                  onChangedFunction: (v) => phoneNumber = v,
                ),

                const SizedBox(height: 16),

                CustoumTextField(
                  hintName: 'Position',
                  controller: controller.positionController,
                  obsecureText: false,
                  width: double.infinity,
                  onChangedFunction: (v) => position = v,
                ),

                const SizedBox(height: 16),

                CustomDropdown(
                  hintName: 'Inquiry Type',
                  width: double.infinity,
                  value: controller.selectedInquiryType,
                  items: controller.inquiryTypeModel,
                  labelBuilder: (item) => item?.inquiryType ?? '',
                  onChanged: (val) {
                    controller.setSelectedInquiryType(val ?? '-');
                  },
                ),

                const SizedBox(height: 16),

                CustoumTextField(
                  hintName: 'Message',
                  controller: controller.messageController,
                  obsecureText: false,
                  width: double.infinity,
                  maxLines: 5,
                  onChangedFunction: (v) => message = v,
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Get.find<GlobalController>().insertUser(
                        name: controller.nameController.text,
                        email: controller.emailController.text,
                        companyName: controller.companyController.text,
                        message: controller.messageController.text,
                        position: controller.positionController.text,
                        phoneNumber: controller.phoneController.text,
                        inquiryType: controller.selectedInquiryType,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'SUBMIT',
                      style: whiteTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.contactModel.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 180,
            ),
            itemBuilder: (_, index) {
              final data = controller.contactModel[index];

              return cardContactMobile(
                name: data.name,
                phoneNumber: data.phoneNumber,
                email: data.email,
                image: data.image,
              );
            },
          ),
        ],
      ),
    );
  }

  return GetBuilder<Contactuscontroller>(
    builder: (controller) {
      return ResponsiveLayout(
        mobile: personalDataMobile(controller),
        desktop: personalDataDesktop(controller),
      );
    },
  );
}
