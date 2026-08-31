import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project/controller/globalController.dart';
import 'package:project/global%20widget/customButton.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/theme.dart';

class Contact extends StatelessWidget {
  Contact({super.key});
  var globalController = Get.find<GlobalController>();

  Widget locationTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget contactItem({
    required String title,
    required String phone,
    required String email,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5, bottom: 8),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          GestureDetector(
            onTap: () {
              globalController.openWhatsApp(
                phone.replaceAll('+', '').replaceAll('-', ''),
                'I opened the Indocool website, I want to communicate with your sales!',
              );
            },
            child: Text(
              phone,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),

          const SizedBox(height: 5),

          GestureDetector(
            onTap: () {
              globalController.sendEmail(email: email);
            },
            child: Text(
              email,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Globalappbar(
      isNeedInquiryPage: false,
      pageWidget: Column(
        children: [
          // ============================================================
          // HERO SECTION
          // ============================================================
          Stack(
            children: [
              Image.asset(
                AppImages().contactPage,
                width: double.infinity,
                height: 700,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 120, top: 165),
                child: SizedBox(
                  width: Get.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Have a question?\n'
                        'Get an answer directly\n'
                        'from the experts.',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 60),

                      Text(
                        'Ask us any questions, such as the causes of radiator overheating, the\n'
                        'right heat exchanger products for heavy equipment, preventive measures to\n'
                        'stay productive by maintaining your heat exchangers, and much more.\n'
                        '\n'
                        'Contact our team, leave the rest to us, and you can focus on keeping your\n'
                        'operations running smoothly.',
                        style: whiteTextStyle.copyWith(fontWeight: medium),
                      ),

                      const SizedBox(height: 60),

                      bookServiceSchedule(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 75),

          // ============================================================
          // CONTACT SECTION - BLACK BACKGROUND
          // ============================================================
          Container(
            width: 1800,
            color: kBlackColor,
            padding: const EdgeInsets.only(top: 48, bottom: 50),
            child: Column(
              children: [
                // ======================================================
                // TITLE
                // ======================================================
                Container(
                  width: 520,
                  height: 43,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFFF6600),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'INDOCOOL QUICK CONTACT LINE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // ======================================================
                // MAIN COMMERCIAL TITLE
                // ======================================================
                SizedBox(
                  width: 1650,
                  child: const Text(
                    'MAIN COMMERCIAL CONTACT LIST',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ======================================================
                // MAIN COMMERCIAL CONTACT BOX
                // ======================================================
                Center(
                  child: Container(
                    width: 1650,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // COLUMN 1
                        Expanded(
                          child: Column(
                            children: [
                              contactItem(
                                title: 'Customer Support',
                                phone: '+62812-1000-256',
                                email: 'customersupport@indocool.co.id',
                              ),

                              contactItem(
                                title: 'Industrial Sales Engineer',
                                phone: '+62811-1902-1565',
                                email: 'sales2@indocool.co.id',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // COLUMN 2
                        Expanded(
                          child: Column(
                            children: [
                              contactItem(
                                title: 'International Sales',
                                phone: '+62811-1188-861',
                                email: 'sales.manager@indocool.co.id',
                              ),

                              contactItem(
                                title: 'Mining Sales Engineer',
                                phone: '+62811-8339-7261',
                                email: 'sales3@indocool.co.id',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // COLUMN 3
                        Expanded(
                          child: Column(
                            children: [
                              contactItem(
                                title: 'Coolant Specialist',
                                phone: '+62811-1148-086',
                                email: 'coolant@indocool.co.id',
                              ),

                              contactItem(
                                title: 'Kalimantan Area Sales',
                                phone: '+62811-8141-0282',
                                email: 'salesbpn@indocool.co.id',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ======================================================
                // TECHNICAL / OPERATIONAL TITLE
                // ======================================================
                SizedBox(
                  width: 1650,
                  child: const Text(
                    'TECHNICAL / OPERATIONAL CONTACT LIST',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ======================================================
                // TECHNICAL / OPERATIONAL CONTACT BOX
                // ======================================================
                Center(
                  child: Container(
                    width: 1650,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================================================
                        // JAKARTA
                        // ==================================================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              locationTitle('JAKARTA'),

                              contactItem(
                                title: 'Service / Repair Manager',
                                phone: '+62 812-1058-882',
                                email: 'service@indocool.co.id',
                              ),

                              contactItem(
                                title: 'Engineering',
                                phone: '+62811-1188-863',
                                email: 'engineering@indocool.co.id',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // ==================================================
                        // BALIKPAPAN
                        // ==================================================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              locationTitle('BALIKPAPAN'),

                              contactItem(
                                title: 'Branch Head Balikpapan',
                                phone: '+62811-1188-861',
                                email: 'servicebpn@indocool.co.id',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 20),

                        // ==================================================
                        // SANGATTA
                        // ==================================================
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              locationTitle('SANGATTA'),

                              contactItem(
                                title: 'Branch Head Sangatta',
                                phone: '+62811-1927-6530',
                                email: 'servicesgt@indocool.co.id',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 75),
        ],
      ),
    );
  }
}
