import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:project/Inquiry/controller/inquiry_controller.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global_widget/baseLayoutWrapper.dart';
import 'package:project/global_widget/globalAppBar.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';

class InquiryPage extends StatelessWidget {
  final InquiryController _controller = Get.find<InquiryController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalController globalController = Get.find<GlobalController>();

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

  // ============================================================
  // DIRECT CONSULTATION
  // ============================================================

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

          // TITLE
          Text(
            'Direct Consultation',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 28),

          // WHATSAPP
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

          // EMAIL
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

          // LOCATION
          GestureDetector(
            onTap: () async {
              await globalController.openLocation();
            },
            child: consultationItem(
              icon: Icons.location_on_outlined,
              title: 'Head Office Location',
              subtitle: 'Jakarta, Indonesia',
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ============================================================
  // CONSULTATION ITEM
  // ============================================================

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
          // ICON
          SizedBox(width: 60, child: Icon(icon, color: Colors.white, size: 48)),

          const SizedBox(width: 14),

          // TEXT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget inquiryTextField({
    required String hint,
    required TextEditingController controller,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,

        // Text yang diketik
        style: const TextStyle(fontSize: 13, color: Colors.black),

        decoration: InputDecoration(
          // Placeholder
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: Colors.black),

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

  // ============================================================
  // INQUIRY FORM
  // ============================================================

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
          // ======================================================
          // NAME + COMPANY
          // ======================================================
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

          // ======================================================
          // POSITION + LOCATION
          // ======================================================
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

          // ======================================================
          // EMAIL + PHONE
          // ======================================================
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

          // ======================================================
          // INQUIRY TYPE + ATTACH FILE
          // ======================================================
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

          // ======================================================
          // DESCRIPTION
          // ======================================================
          SizedBox(
            height: 75,
            child: inquiryTextField(
              hint:
                  'Describe your equipment, application, cooling challenge, requirements, or quantity of products.',
              controller: descriptionController,
            ),
          ),

          const SizedBox(height: 15),

          // ======================================================
          // SUBMIT BUTTON
          // ======================================================
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

  // ============================================================
  // INQUIRY TYPE DROPDOWN
  // ============================================================

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

        // Dropdown hint
        hint: const Text(
          'Inquiry type (product, service, ...)',
          style: TextStyle(fontSize: 13, color: Colors.black),
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

        // Dropdown items
        items: List.generate(_controller.inquiryTypeModel.length, (index) {
          var data = _controller.inquiryTypeModel[index];

          return DropdownMenuItem<String>(
            value: data.inquiryType,
            child: Text(
              data.inquiryType,
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          );
        }),

        onChanged: (value) {
          if (value == null) return;

          _controller.setSelectedInquiryType(value);
        },
      ),
    );
  }

  // ============================================================
  // ATTACH FILE
  // ============================================================

  Widget attachFileField() {
    return SizedBox(
      height: 40,
      child: TextField(
        readOnly: true,

        style: const TextStyle(fontSize: 13, color: Colors.black),

        decoration: InputDecoration(
          hintText: _controller.fileName ?? 'Attach supporting file',

          hintStyle: const TextStyle(fontSize: 13, color: Colors.black),

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

  // ============================================================
  // MOBILE
  // ============================================================

  Widget mobileWidget() {
    return Container();
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget desktopWidget() {
    return Column(
      children: [
        const SizedBox(height: 20),

        // PAGE TITLE
        Text(
          'INQUIRY',
          style: blackTextStyle.copyWith(fontSize: 50, fontWeight: bold),
        ),

        const SizedBox(height: 20),

        // CONTENT
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DIRECT CONSULTATION
            SizedBox(width: 320, child: directConsultation()),

            const SizedBox(width: 40),

            // INQUIRY FORM
            SizedBox(width: 1000, child: inquiryForm()),
          ],
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}
