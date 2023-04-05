import 'package:cdb_mobile/features/domain/entities/response/biller_category_entity.dart';

import '../../../data/models/responses/get_biller_list_response.dart';
import '../base_state.dart';

abstract class BillerManagementState extends BaseState<BillerManagementState> {}

class InitialBillerManagementState extends BillerManagementState {}

class GetSavedBillersSuccessState extends BillerManagementState {
  final GetSavedBillersResponse response;

  GetSavedBillersSuccessState({this.response});
}

class GetSavedBillersFailedState extends BillerManagementState {
  final String message;

  GetSavedBillersFailedState({this.message});
}

class AddBillerFailedState extends BillerManagementState {
  final String message;

  AddBillerFailedState({this.message});
}

class AddBillerSuccessState extends BillerManagementState {
  final int billerId;

  AddBillerSuccessState({this.billerId});
}

class FavouriteBillerSuccessState extends BillerManagementState {
  final int billerId;

  FavouriteBillerSuccessState({this.billerId});
}

class FavouriteBillerFailedState extends BillerManagementState {
  final String message;

  FavouriteBillerFailedState({this.message});
}

class DeleteBillerSuccessState extends BillerManagementState {
  final int billerId;

  DeleteBillerSuccessState({this.billerId});
}

class DeleteBillerFailedState extends BillerManagementState {
  final String message;

  DeleteBillerFailedState({this.message});
}

class GetBillerCategoryListFailedState extends BillerManagementState {
  final String message;

  GetBillerCategoryListFailedState({this.message});
}

class GetBillerCategorySuccessState extends BillerManagementState {
  final List<BillerCategoryEntity> billerCategoryList;

  GetBillerCategorySuccessState({this.billerCategoryList});
}

class EditUserBillerSuccessState extends BillerManagementState {
  final int billerId;

  EditUserBillerSuccessState({this.billerId});
}

class EditUserBillerFailedState extends BillerManagementState {
  final String message;

  EditUserBillerFailedState({this.message});
}

class UnFavouriteBillerSuccessState extends BillerManagementState {
  final int billerId;

  UnFavouriteBillerSuccessState({this.billerId});
}

class UnFavouriteBillerFailedState extends BillerManagementState {
  final String message;

  UnFavouriteBillerFailedState({this.message});
}
