import 'package:cdb_mobile/features/data/models/requests/add_biller_request.dart';
import 'package:cdb_mobile/features/domain/entities/response/custom_field_entity.dart';

import '../base_event.dart';

abstract class BillerManagementEvent extends BaseEvent {}

class GetSavedBillersEvent extends BillerManagementEvent {}

class AddBillerEvent extends BillerManagementEvent {
  final String nickName;
  final int serviceProviderId;
  final List<CustomFieldEntity> customFields;

  AddBillerEvent({this.nickName, this.serviceProviderId, this.customFields});
}

class FavouriteBillerEvent extends BillerManagementEvent {
  final int billerId;

  FavouriteBillerEvent({this.billerId});
}

class DeleteBillerEvent extends BillerManagementEvent {
  final int billerId;

  DeleteBillerEvent({this.billerId});
}

class GetBillerCategoryListEvent extends BillerManagementEvent {}

class EditUserBillerEvent extends BillerManagementEvent {
  final String nickName;
  final String serviceProviderId;
  final int billerId;
  final String categoryId;
  final List<CustomFieldEntity> fieldList;

  EditUserBillerEvent(
      {this.nickName,
      this.serviceProviderId,
      this.billerId,
      this.categoryId,
      this.fieldList});
}

class UnFavoriteBillerEvent extends BillerManagementEvent {
  final int billerId;

  UnFavoriteBillerEvent({this.billerId});
}
