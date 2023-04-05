
import 'package:cdb_mobile/features/domain/entities/request/delete_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/favourite_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/un_favorite_biller_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/delete_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/favourite_biller.dart';

import 'package:cdb_mobile/features/data/models/requests/edit_user_biller_request.dart';
import 'package:cdb_mobile/features/domain/entities/request/edit_user_biller_request_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/edit_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/unFavoriteBiller.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/add_biller_request.dart';
import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/charee_code_entity.dart';
import '../../../domain/entities/response/custom_field_entity.dart';
import '../../../domain/usecases/biller_management/add_biller.dart';
import '../../../domain/usecases/biller_management/get_biller_categories.dart';
import '../../../domain/usecases/biller_management/saved_billers.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'biller_management_event.dart';
import 'biller_management_state.dart';

class BillerManagementBloc
    extends BaseBloc<BillerManagementEvent, BaseState<BillerManagementState>> {
  final GetSavedBillers getSavedBillers;
  final GetBillerCategoryList getBillerCategoryList;
  final AddBiller addBiller;
  final FavouriteBiller favouriteBiller;
  final DeleteBiller deleteBiller;
  final EditUserBiller editUserBiller;
  final UnFavoriteBiller unFavoriteBiller;

  BillerManagementBloc(
      {this.unFavoriteBiller,
      this.favouriteBiller,
      this.deleteBiller,
      this.getSavedBillers,
      this.addBiller,
      this.getBillerCategoryList,
      this.editUserBiller})
      : super(InitialBillerManagementState());

  @override
  Stream<BaseState<BillerManagementState>> mapEventToState(
      BillerManagementEvent event) async* {
    if (event is GetSavedBillersEvent) {
      yield APILoadingState();
      final _result = await getSavedBillers(
        const CommonRequestEntity(
          messageType: kGetSavedBillersRequestType,
        ),
      );

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return GetSavedBillersFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return GetSavedBillersSuccessState(response: r.data);
      });
    } else if (event is AddBillerEvent) {
      yield APILoadingState();
      final _result = await addBiller(
        AddBillerRequest(
            messageType: kAddBillerRequestType,
            nickName: event.nickName,
            serviceProviderId: event.serviceProviderId,
            fieldList: event.customFields
                .map(
                  (e) => FieldList(
                      customFieldValue: e.userValue,
                      customFieldId: e.customFieldId),
                )
                .toList()),
      );

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return AddBillerFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return AddBillerSuccessState(billerId: r.data.id);
      });
    } else if (event is GetBillerCategoryListEvent) {
      yield APILoadingState();
      final _result = await getBillerCategoryList(const CommonRequestEntity(
        messageType: kGetBillerCategoryListRequestType,
      ));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return GetBillerCategoryListFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        var categoryList = r.data.data
            .map(
              (e) => BillerCategoryEntity(
                  categoryId: e.id,
                  categoryCode: e.code,
                  categoryName: e.name,
                  status: e.status,
                  categoryDescription: e.description,
                  billers: e.dbpBspMetaCollection
                      .map(
                        (f) => BillerEntity(
                            billerId: f.id,
                            status: f.status,
                            billerCode: f.id.toString(),
                            billerName: f.name,
                            description: f.description,
                            billerImage: f.imageUrl,
                            collectionAccount: f.collectionAccount,
                            displayName: f.displayName,
                            chargeCodeEntity: ChargeCodeEntity(
                                chargeCode: '',
                                chargeAmount: 0),
                            customFieldList: f.dbpBspMetaCustomFieldCollection
                                .map(
                                  (a) => CustomFieldEntity(
                                      customFieldId: a.id.toString(),
                                      customFieldName: a.name,
                                      customFieldValue: a.value,
                                      placeholder: a.placeHolder,
                                      customFieldDetailsEntity:
                                          CustomFieldDetailsEntity(
                                              id: a.id,
                                              name: a.name,
                                              length: a.length??'50',
                                              validation: a.validation,
                                              fieldTypeEntity: FieldTypeEntity(
                                                  name: a.fieldType.name,
                                                  id: a.fieldType.id))),
                                )
                                .toList()),
                      )
                      .toList()),
            )
            .toList();

        return GetBillerCategorySuccessState(billerCategoryList: categoryList);
      });
    } else if (event is FavouriteBillerEvent) {
      yield APILoadingState();
      final _result = await favouriteBiller(FavouriteBillerEntity(
          billerId: event.billerId, messageType: kFavouriteBillerRequestType));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return FavouriteBillerFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return FavouriteBillerSuccessState();
      });
    } else if (event is DeleteBillerEvent) {
      yield APILoadingState();
      final _result = await deleteBiller(DeleteBillerEntity(
          billerId: event.billerId, messageType: kDeleteBillerRequestType));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return DeleteBillerFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return DeleteBillerSuccessState();
      });
    } else if (event is EditUserBillerEvent) {
      yield APILoadingState();
      final _result = await editUserBiller(
        EditUserBillerRequest(
            messageType: kEditBillerRequestType,
            nickName: event.nickName,
            serviceProviderId: event.serviceProviderId,
            billerId: event.billerId,
            categoryId: event.categoryId,
            fieldList: event.fieldList
                .map((e) => FieldList(
                    customFieldValue: e.customFieldValue,
                    customFieldId: e.customFieldId))
                .toList()),
      );

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return EditUserBillerFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return EditUserBillerSuccessState();
      });
    } else if (event is UnFavoriteBillerEvent) {
      yield APILoadingState();
      final _result = await unFavoriteBiller(UnFavoriteBillerEntity(
          billerId: event.billerId, messageType: kUnFavoriteBillerRequestType));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return UnFavouriteBillerFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return UnFavouriteBillerSuccessState();
      });
    }
  }
}
