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
        color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: productDetails.map((e) {
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    style: greyTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString().detailProduct,
              style: blackTextStyle.copyWith(
                fontSize: 16.sp,
                // Ukuran font responsif
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 10.h),
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
            Text('COBAA'),
          ],
        ),
      ),
    );
  }
}
