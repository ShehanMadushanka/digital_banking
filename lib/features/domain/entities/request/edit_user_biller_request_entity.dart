import 'package:cdb_mobile/features/data/models/requests/add_biller_request.dart';

import '../../../data/models/requests/edit_user_biller_request.dart';

class EditUserBillerRequestEntity extends EditUserBillerRequest {
  EditUserBillerRequestEntity({
    this.messageType,
    this.nickName,
    this.serviceProviderId,
    this.billerId,
    this.categoryId,
    this.fieldList,
  }) : super(
    messageType: messageType,
    nickName: nickName,
    serviceProviderId: serviceProviderId,
    billerId: billerId,
    categoryId: categoryId,
    fieldList: fieldList,
  );

  String messageType;
  String clientTransId;
  String nickName;
  String serviceProviderId;
  int billerId;
  String categoryId;
  List<FieldList> fieldList;
}

