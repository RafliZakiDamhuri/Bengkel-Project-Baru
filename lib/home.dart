import 'package:flutter/material.dart';
import 'package:project/appbar/appbar_element.dart';
import 'package:project/appbar/list_home.dart';
import 'package:project/tema/theme.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(right: 500, bottom: 2),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/Screenshot 2025-12-11 151416.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Buku Bengkel',
                    style: blueTextStyle.copyWith(fontWeight: bold),
                  ),
                ],
              ),
            ),

            // SizedBox(width: 1000),
            Row(
              children: [
                AppbarElement(title: 'Home'),
                AppbarElement(title: 'About us'),
                AppbarElement(title: 'Contact'),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 180, left: 250),
                      child: Text(
                        'Solusi Terbaik\nuntuk Mengelola\nBengkelmu!',
                        style: blackTextStyle.copyWith(
                          fontSize: 50,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 250),
                      child: Text(
                        'Ubah bengkel Anda menjadi bengkel profesional dengan\nsolusi pengelolaan dari Buku Bengkel.',
                        style: greyTextStyle.copyWith(fontWeight: light),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(left: 250),
                  width: 800,
                  height: 800,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Screenshot 2025-12-11 181957.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 100),
                  width: 800,
                  height: 800,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/Screenshot 2025-12-11 181957.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 250),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fitur Fitur Terbaik dalam Satu Platform',
                        style: blackTextStyle.copyWith(fontSize: 30),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 40),
                            child: Text('01', style: blackTextStyle),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40),
                              Text(
                                'Customer Record',
                                style: blackTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'kelola data pelanggan dan riwayat servis kendaraan secara lengkap\ndan mudah, mulai dari informasi kontak hingga riwayat perbaikan dan\npenggantian suku cadang ',
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: light,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 2,
                        width: 700,
                        color: Colors.grey.shade300,
                      ),

                      /// nannnti di jadiin 1 widget
                      SizedBox(height: 15),
                      ListHome(nomer: '02', title: 'Transaction Management'),
                      SizedBox(height: 15),
                      Container(
                        height: 2,
                        width: 700,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 15),
                      ListHome(nomer: '03', title: 'Comprehensive Report'),
                      SizedBox(height: 15),
                      Container(
                        height: 2,
                        width: 700,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 15),
                      ListHome(nomer: '04', title: 'Custom Method'),
                      SizedBox(height: 15),
                      Container(
                        height: 2,
                        width: 700,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 15),
                      ListHome(nomer: '05', title: 'Custom Management'),
                      SizedBox(height: 15),
                      Container(
                        height: 2,
                        width: 700,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
