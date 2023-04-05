import 'package:cdb_mobile/features/data/models/requests/terms_acccept_request_model.dart';

class TermsAcceptRequestEntity extends TermsAcceptRequestModel {
  TermsAcceptRequestEntity({
    termId,
    acceptedDate,
    messageType,
  }) : super(
            termId: termId,
            acceptedDate: acceptedDate,
            messageType: messageType);
}
