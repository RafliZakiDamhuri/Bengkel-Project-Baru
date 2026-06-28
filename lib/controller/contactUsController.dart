import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/model/contactModel.dart';
import 'package:project/model/inquiryType.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Contactuscontroller extends GetxController {
  List<ContactModel> contactModel = [];
  final supabase = Supabase.instance.client;
  List<InquiryTypeModel> inquiryTypeModel = [];
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final positionController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  String? selectedInquiryType;
  Future<void> getContact() async {
    final response = await supabase.from('Contact').select();
    contactModel = response.map((e) => ContactModel.fromJson(e)).toList();
    print('Ini adalah response ::::: $response');
    update();
  }

  Future getAllInquiryType() async {
    final response = await supabase.from('InquiryType').select();
    print('Ini adalah response get inquiryType ::: $response');
    inquiryTypeModel = response
        .map((e) => InquiryTypeModel.fromJson(e))
        .toList();

    update();
  }

  void setSelectedInquiryType(String value) {
    selectedInquiryType = value;
    update();
  }
}
