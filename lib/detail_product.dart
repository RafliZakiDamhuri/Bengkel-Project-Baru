import 'package:flutter/material.dart';
import 'package:project/model/allDataModel.dart';
import 'package:project/theme/string.dart';
import 'package:project/theme/theme.dart';
import 'package:sizer/sizer.dart';

class DetailProduct extends StatelessWidget {
  final AllDataModel allDataModel;
  const DetailProduct({super.key, required this.allDataModel});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop(double width) => width >= 900;

    bool isTablet(double width) => width >= 600 && width < 900;

    bool isMobile(double width) => width < 600;
    final productDetails = [
      {'label': AppString().ISCPN, "value": allDataModel.productCode ?? ''},
      {
        'label': AppString().OEMPN,
        "value": allDataModel.platNumber?.platNumber ?? '',
      },
      {'label': AppString().Make, "value": allDataModel.make?.makeName ?? ''},
      {
        'label': AppString().Model,
        "value": allDataModel.modelData?.modelName ?? '',
      },
      {
        'label': AppString().Application,
        "value": allDataModel.applicationRel?.applicationName ?? '',
      },
      {
        'label': AppString().Alternative,
        "value": allDataModel.alternativeModel?.alternative ?? '',
      },
      {'label': AppString().Height, "value": allDataModel.height ?? ''},
      {'label': AppString().Width, "value": allDataModel.weight ?? ''},
      {'label': AppString().Thickness, "value": allDataModel.thickness ?? ''},
      {
        'label': AppString().Material,
        "value": allDataModel.material?.materialName ?? '',
      },
      {
        'label': AppString().EquipmentType,
        "value": allDataModel.equipmentTypeModel?.equipmentType ?? '',
      },
      {'label': AppString().Compatible, "value": allDataModel.compatible ?? ''},
    ];
    String judul =
        '${allDataModel.coreTypeModel?.coreType} ${allDataModel.applicationRel?.applicationName} ${allDataModel.make?.makeName} ${allDataModel.modelData?.modelName}';

    Widget detailProductWidget() {
      return Container(
        width: screenWidth * 0.5,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/D85ESS-Transp 1.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: productDetails.map((e) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${e['label']} : ',
                            textAlign: TextAlign.start,
                            style: greyTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '${e['value']}',
                            style: greyTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: screenWidth * 0.03,
                top: screenWidth * 0.01,
              ),
              child: Text(
                AppString().detailProduct,
                style: blackTextStyle.copyWith(
                  fontSize: 16.sp,
                  // Ukuran font responsif
                  fontWeight: bold,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    judul,
                    style: blackTextStyle.copyWith(
                      fontSize: 16.sp,
                      // Ukuran font responsif
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),

            Center(child: detailProductWidget()),
            SizedBox(height: 8.h),

            Container(
              margin: EdgeInsets.only(
                left: screenWidth * 0.03,
                top: screenWidth * 0.01,
              ),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: isMobile(screenWidth) ? 12.sp : 12.sp,
                  fontWeight: bold,
                ),
              ),
            ),
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.only(top: screenWidth * 0.05),
            //     width: screenWidth * 0.2,
            //     decoration: BoxDecoration(
            //       color: kGreyColor,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Center(
            //       child: TextButton(onPressed: () {}, child: Text('pencet')),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
