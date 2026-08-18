import 'package:flutter/material.dart';
import 'package:project/global%20widget/baseLayoutWrapper.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/theme.dart';

class InquaryPage extends StatelessWidget {
  const InquaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(
      pageWidget: SingleChildScrollView(
        child: Column(
          children: [
            ResponsiveLayout(mobile: mobileWidget(), desktop: desktopWidget()),
          ],
        ),
      ),
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

          consultationItem(
            icon: Icons.phone,
            title: 'WhatsApp Message or Call',
            subtitle: '+62812-1000-256',
          ),

          const SizedBox(height: 10),

          consultationItem(
            icon: Icons.email_outlined,
            title: 'Email Address',
            subtitle: 'customersupport@indocool.co.id',
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

  Widget inquiryTextField({required String hint}) {
    return SizedBox(
      height: 40,
      child: TextField(
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
              Expanded(child: inquiryTextField(hint: 'Enter your name')),

              const SizedBox(width: 15),

              Expanded(child: inquiryTextField(hint: 'Company name')),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(child: inquiryTextField(hint: 'Position')),

              const SizedBox(width: 15),

              Expanded(child: inquiryTextField(hint: 'Location')),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(child: inquiryTextField(hint: 'Enter your email')),

              const SizedBox(width: 15),

              Expanded(child: inquiryTextField(hint: 'Phone number')),
            ],
          ),

          const SizedBox(height: 15),

          // Inquiry + Attach
          Row(
            children: [
              Expanded(child: inquiryTypeField()),
              const SizedBox(width: 15),
              Expanded(child: attachFileField()),
            ],
          ),

          const SizedBox(height: 15),

          // Description
          SizedBox(
            height: 75,
            child: inquiryTextField(
              hint:
                  'Describe your equipment, application, cooling challenge, requirements, or quantity of products.',
            ),
          ),

          const SizedBox(height: 15),

          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 180,
              height: 35,
              child: ElevatedButton(
                onPressed: () {},
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
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Inquiry type (product, service, ...)',
          hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFE3F2FD),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          suffixIcon: const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: Colors.black,
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

  Widget attachFileField() {
    return SizedBox(
      height: 40,
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Attach supporting file',
          hintStyle: const TextStyle(fontSize: 10, color: Colors.grey),
          filled: true,
          fillColor: const Color(0xFFE3F2FD),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          suffixIcon: const Icon(Icons.upload, size: 18, color: Colors.black),
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
