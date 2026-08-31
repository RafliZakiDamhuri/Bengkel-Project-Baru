import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:project/Inquiry/controller/inquiry_controller.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/model/productModel.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class InquiryPage extends StatelessWidget {
  final InquiryController _controller = Get.find<InquiryController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var globalController = Get.find<GlobalController>();

  InquiryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InquiryController>(
      initState: (state) {
        _controller.getAllInquiryType();
      },
      builder: (controller) {
        return Globalappbar(
          isNeedInquiryPage: false,
          pageWidget: SingleChildScrollView(
            child: Column(
              children: [
                ResponsiveLayout(
                  mobile: mobileWidget(),
                  desktop: desktopWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget directConsultation() {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0864C5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          Text(
            'Direct Consultation',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 28),

          GestureDetector(
            onTap: () {
              globalController.openWhatsApp(
                AppString().indocoolWhatsappNumber,
                'I opened the Indocool website, I want to communicate with your sales!',
              );
            },
            child: consultationItem(
              icon: Icons.phone,
              title: 'WhatsApp Message or Call',
              subtitle: '+62812-1000-256',
            ),
          ),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: () async {
              await globalController.sendEmail();
            },
            child: consultationItem(
              icon: Icons.email_outlined,
              title: 'Email Address',
              subtitle: 'customersupport@indocool.co.id',
            ),
          ),

          const SizedBox(height: 10),

          consultationItem(
            icon: Icons.location_on_outlined,
            title: 'Head Office Location',
            subtitle: 'Jakarta, Indonesia',
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget consultationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF0875E0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SizedBox(width: 60, child: Icon(icon, color: Colors.white, size: 48)),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inquiryTextField({
    required String hint,
    required TextEditingController controller,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFE3F2FD),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget inquiryForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Place Your Inquiry Here',
            style: blackTextStyle.copyWith(fontSize: 22, fontWeight: bold),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: inquiryTextField(
                  hint: 'Enter your name',
                  controller: nameController,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: inquiryTextField(
                  hint: 'Company name',
                  controller: companyNameController,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: inquiryTextField(
                  hint: 'Position',
                  controller: positionController,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: inquiryTextField(
                  hint: 'Location',
                  controller: locationController,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: inquiryTextField(
                  hint: 'Enter your email',
                  controller: emailController,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: inquiryTextField(
                  hint: 'Phone number',
                  controller: phoneNumberController,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Inquiry + Attach
          Row(
            children: [
              Expanded(child: inquiryTypeField()),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await _controller.pickAndUploadFile();
                  },
                  child: attachFileField(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Description
          SizedBox(
            height: 75,
            child: inquiryTextField(
              hint:
                  'Describe your equipment, application, cooling challenge, requirements, or quantity of products.',
              controller: descriptionController,
            ),
          ),

          const SizedBox(height: 15),

          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 180,
              height: 35,
              child: ElevatedButton(
                onPressed: () async {
                  await _controller.uploadResourcesToSupabase(
                    name: nameController.text,
                    companyName: companyNameController.text,
                    position: positionController.text,
                    location: locationController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    description: descriptionController.text,
                  );
                },
                child: const Text('SUBMIT'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inquiryTypeField() {
    return SizedBox(
      height: 40,
      child: DropdownButtonFormField<String>(
        value: null,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 20,
          color: Colors.black,
        ),
        hint: const Text(
          'Inquiry type (product, service, ...)',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFE3F2FD),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        items: List.generate(_controller.inquiryTypeModel.length, (index) {
          var data = _controller.inquiryTypeModel[index];
          return DropdownMenuItem<String>(
            value: data.inquiryType,
            child: Text(data.inquiryType, style: const TextStyle(fontSize: 10)),
          );
        }),

        onChanged: (value) {
          if (value == null) return;

          _controller.setSelectedInquiryType(value);
        },
      ),
    );
  }

  Widget attachFileField() {
    return SizedBox(
      height: 40,
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: _controller.fileName ?? 'Attach supporting file',
          hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFE3F2FD),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          suffixIcon: GestureDetector(
            onTap: () async {
              await _controller.pickAndUploadFile();
            },
            child: const Icon(Icons.upload, size: 18, color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget mobileWidget() {
    return Container();
  }

  Widget desktopWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 320, child: directConsultation()),

        const SizedBox(width: 40),

        SizedBox(width: 1000, child: inquiryForm()),
      ],
    );
  }
}
