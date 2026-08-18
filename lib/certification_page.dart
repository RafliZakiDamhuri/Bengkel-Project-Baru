import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/global%20widget/globalAppBar.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/theme.dart';

class CertificationPage extends StatelessWidget {
  const CertificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Globalappbar(pageWidget: _content());
  }

  Widget articleParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.black87,
          height: 1.7,
        ),
      ),
    );
  }

  Widget articleQuote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: kBlueColor, width: 4)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Colors.black87,
          height: 1.7,
        ),
      ),
    );
  }

  Widget insightNewsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Garis atas
          Container(width: double.infinity, height: 1, color: Colors.black),

          const SizedBox(height: 35),

          Text(
            'Indocool Insight and News',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 40),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: insightNewsCard(
                  image: AppImages().isoCertification,
                  category: 'Company News',
                  date: '29 August 2025',
                  title:
                      'PT Indocool Solusi Cemerlang Achieves ISO 9001: 2015, '
                      'ISO 14001: 2015, and ISO 45001: 2018 Certifications',
                ),
              ),

              const SizedBox(width: 35),

              Expanded(
                child: insightNewsCard(
                  image: AppImages().komatsuD85,
                  category: 'Product Insight',
                  date: '29 August 2025',
                  title:
                      'The Best & Most Demanding Product for Handling Built-in '
                      'Cooling System Problems in KOMATSU D85ESS',
                ),
              ),

              const SizedBox(width: 35),

              Expanded(
                child: insightNewsCard(
                  image: AppImages().medicalCheckup,
                  category: 'Company News',
                  date: '29 August 2025',
                  title:
                      'To Maintain Productivity and Compliance With Government '
                      'Mandates, Indocool Conducts Medical Check-ups',
                ),
              ),
            ],
          ),

          const SizedBox(height: 50),

          // See More Content
          Center(
            child: Container(
              width: 210,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFD6EEFF),
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'See More Content',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 30),

                  const Icon(
                    Icons.arrow_forward,
                    size: 24,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget insightNewsCard({
    required String image,
    required String category,
    required String date,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            image,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 15),

        // CATEGORY + DATE
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFC8E9FF),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF0864C5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Text(
                  date,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // TITLE
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _content() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // TITLE
              // =========================
              Text(
                'PT Indocool Solusi Cemerlang Achieves ISO 9001: 2015, '
                'ISO 14001: 2015, and ISO 45001: 2018 Certifications',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              // =========================
              // IMAGE
              // =========================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/images/iso_certification.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 38),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Written by: Shavira Zahra Khatulistiwa',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                    Text(
                      'Released Date: 26 August 2025',
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 38),
              // PARAGRAF 1
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.7,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Bogor, Indonesia – August 26, 2025 – ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          'PT Indocool Solusi Cemerlang (INDOCOOL Group), a leading '
                          'manufacturer and service provider of radiator and heat '
                          'exchanger solutions for the mining, power generation, '
                          'oil & gas, marine, and industrial sectors, proudly '
                          'announces the successful achievement of ISO 9001:2015 '
                          '(Quality Management System), ISO 14001:2015 '
                          '(Environmental Management System), and ISO 45001:2018 '
                          '(Occupational Health and Safety Management System) '
                          'certifications.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // PARAGRAF 2
              articleParagraph(
                'The achievement of these internationally recognized certifications '
                'marks a significant milestone in the company\'s continuous journey '
                'toward operational excellence, sustainable business practices, and '
                'the highest standards of workplace health and safety.',
              ),

              // PARAGRAF 3
              articleParagraph(
                'ISO 9001:2015 demonstrates INDOCOOL Group\'s commitment to delivering '
                'consistent product quality, improving customer satisfaction, and '
                'continually enhancing its management processes. The certification '
                'reflects the company\'s ability to meet customer expectations while '
                'maintaining efficient and standardized operational procedures '
                'across its manufacturing and service activities.',
              ),

              // PARAGRAF 4
              articleParagraph(
                'The implementation of ISO 14001:2015 further strengthens the '
                'company\'s environmental responsibility by promoting sustainable '
                'practices throughout its operations. Through this environmental '
                'management system, INDOCOOL Group is committed to minimizing '
                'environmental impacts, improving resource efficiency, reducing '
                'waste, and ensuring compliance with applicable environmental '
                'regulations.',
              ),

              // PARAGRAF 5
              articleParagraph(
                'In addition, ISO 45001:2018 recognizes the company\'s dedication '
                'to providing a safe and healthy workplace for employees, '
                'contractors, and business partners. By adopting internationally '
                'recognized occupational health and safety management practices, '
                'INDOCOOL Group continues to identify potential risks, prevent '
                'workplace incidents, and foster a strong safety culture '
                'throughout the organization.',
              ),

              // PARAGRAF 6
              articleParagraph(
                'These certifications reflect the collective commitment of every '
                'department and employee within INDOCOOL Group to continuously '
                'improve processes, maintain operational discipline, and deliver '
                'products and services that meet international standards.',
              ),

              // QUOTE MANAGEMENT
              articleParagraph(
                '"As a company serving critical industries such as mining, power '
                'generation, marine, and heavy industrial sectors, maintaining high '
                'standards in quality, environmental management, and occupational '
                'safety is essential to our long-term success. These certifications '
                'reinforce our commitment to providing reliable cooling system '
                'solutions while operating responsibly and sustainably," said the '
                'management of PT Indocool Solusi Cemerlang.',
              ),

              // PARAGRAF 7
              articleParagraph(
                'With more than four decades of industry expertise, INDOCOOL Group '
                'continues to invest in innovation, manufacturing capabilities, and '
                'professional development to better serve customers across Indonesia '
                'and international markets. The newly achieved ISO certifications '
                'further strengthen customer confidence and demonstrate the '
                'company\'s readiness to meet the evolving demands of global '
                'industries.',
              ),

              // PARAGRAF 8
              articleParagraph(
                'Moving forward, PT Indocool Solusi Cemerlang remains committed to '
                'continual improvement, operational excellence, and delivering '
                'high-quality radiator and heat exchanger solutions that support '
                'reliable performance across the industries it serves.',
              ),
              insightNewsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
