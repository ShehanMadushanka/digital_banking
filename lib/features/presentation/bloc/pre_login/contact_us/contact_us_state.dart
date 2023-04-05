import 'package:cdb_mobile/features/data/models/responses/contact_us_response.dart';

import '../../base_state.dart';

abstract class ContactUsState extends BaseState<ContactUsState>{}

class InitialContactUsState extends ContactUsState {}

class ContactUsSuccessState extends ContactUsState {
  String companyName;
  String telNo;
  String email;
  String busAddLine1;
  String busAddLine2;
  String busAddLine3;

  ContactUsSuccessState({
    this.companyName,
    this.telNo,
    this.email,
    this.busAddLine1,
    this.busAddLine2,
    this.busAddLine3,
  });
}

class ContactUsFailedState extends ContactUsState {
  final String message;

  ContactUsFailedState({this.message});
}