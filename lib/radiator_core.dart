import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/product_radiator_core.dart';
import 'package:project/radiator_core_element.dart';
import 'package:project/theme/app_images.dart';
import 'package:project/theme/theme.dart';

class RadiatorCore extends StatelessWidget {
  const RadiatorCore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  'CATERPILLAR® RADIATOR CORE REPLACEMENT',
                  style: blackTextStyle.copyWith(
                    fontSize: 48,
                    fontWeight: bold,
                  ),
                ),
              ),
              SizedBox(height: 27),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RadiatorCoreElement(
                    img: AppImages().foldedCore,
                    title: 'FOLDED CORE',
                  ),
                  SizedBox(width: 40),
                  RadiatorCoreElement(
                    img: AppImages().amocsCore,
                    title: 'AMOCS CORE',
                  ),
                ],
              ),
              SizedBox(height: 47),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RadiatorCoreElement(
                    img: AppImages().modularCore,
                    title: 'MODULAR CORE',
                  ),
                  SizedBox(width: 40),
                  RadiatorCoreElement(
                    img: AppImages().ngmrCore,
                    title: 'NGMR CORE',
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProductRadiatorCore(
                    img: AppImages().foldedSealCore,
                    title: 'FOLDED CORE SEAL',
                  ),
                  ProductRadiatorCore(
                    img: AppImages().amocsSealCore,
                    title: 'AMOCS CORE SEAL',
                  ),
                  ProductRadiatorCore(
                    img: AppImages().modularSealCore,
                    title: 'MODULAR CORE SEAL',
                  ),
                  ProductRadiatorCore(
                    img: AppImages().ngmrSealCore,
                    title: 'NGMR CORE SEAL',
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
