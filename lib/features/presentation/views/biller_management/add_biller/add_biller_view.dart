import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_state.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/app_utils.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../data/models/responses/city_response.dart';
import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../../domain/entities/response/biller_entity.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/drop_down/drop_down_event.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../../widgets/cdb_scrollview.dart';
import '../../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../base_view.dart';
import '../data/add_biller_args.dart';

class AddBillerView extends BaseView {
  @override
  _AddBillerViewState createState() => _AddBillerViewState();
}

class _AddBillerViewState extends BaseViewState<AddBillerView> {
  /// Dependency Injection
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  /// Variables
  List<BillerCategoryEntity> billerCategoryList = [];
  BillerCategoryEntity _billerCategoryEntity;
  BillerEntity _billerEntity;
  String nickName;

  @override
  void initState() {
    super.initState();
    _bloc.add(GetBillerCategoryListEvent());
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleBillers.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is GetBillerCategorySuccessState) {
              setState(() {
                kBillerCategoryList.clear();
                billerCategoryList.clear();
                billerCategoryList.addAll(state.billerCategoryList);
                kBillerCategoryList.addAll(state.billerCategoryList
                    .map(
                      (e) => CommonDropDownResponse(
                          id: e.categoryId,
                          description: e.categoryName,
                          key: e.categoryCode),
                    )
                    .toList());

                try {
                  _billerCategoryEntity = billerCategoryList[0];
                  _billerEntity = _billerCategoryEntity.billers[0];
                  kBillerList.clear();
                  kBillerList.addAll(_billerCategoryEntity.billers
                      .map((e) => CommonDropDownResponse(
                          id: e.billerId,
                          description: e.displayName,
                          key: e.billerCode))
                      .toList());
                } catch (e) {}
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: kTopMarginOnBoarding,
              bottom: kBottomMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CDBScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CdbDropDown(
                          key: const Key("keyBillerCategory"),
                          initialValue: _billerCategoryEntity != null
                              ? _billerCategoryEntity.categoryName
                              : '',
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textDarkColor,
                          ),
                          labelText: AppString.billerCategory.localize(context),
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              Routes.kDropDownView,
                              arguments: DropDownViewScreenArgs(
                                pageTitle:
                                    AppString.billerCategory.localize(context),
                                isSearchable: true,
                                dropDownEvent:
                                    GetBillerCategoriesDropDownEvent(),
                              ),
                            ) as CommonDropDownResponse;

                            if (result != null) {
                              setState(() {
                                final category = billerCategoryList
                                    .where((element) =>
                                        element.categoryId == result.id)
                                    .first;
                                _billerCategoryEntity = category;
                                kBillerList.clear();
                                kBillerList.addAll(category.billers
                                    .map((e) => CommonDropDownResponse(
                                        id: e.billerId,
                                        description: e.displayName,
                                        key: e.billerCode))
                                    .toList());

                                try {
                                  _billerEntity =
                                      _billerCategoryEntity.billers[0];
                                } catch (e) {}
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: kLeftRightMarginOnBoarding,
                        ),
                        CdbDropDown(
                          key: const Key("keyBillerName"),
                          initialValue: _billerEntity != null
                              ? _billerEntity.displayName
                              : '',
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textDarkColor,
                          ),
                          labelText: AppString.billerName.localize(context),
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              Routes.kDropDownView,
                              arguments: DropDownViewScreenArgs(
                                pageTitle:
                                    AppString.billerName.localize(context),
                                isSearchable: true,
                                dropDownEvent: GetBillerListDropDownEvent(),
                              ),
                            ) as CommonDropDownResponse;

                            if (result != null) {
                              setState(() {
                                final biller = _billerCategoryEntity.billers
                                    .where((element) =>
                                        element.billerId == result.id)
                                    .first;
                                _billerEntity = biller;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: kLeftRightMarginOnBoarding,
                        ),
                        CdbCustomTextField(
                          key: const Key("keyNickName"),
                          labelText: AppString.nickName.localize(context),
                          initialValue: '',
                          onChange: (value) {
                            setState(() {
                              nickName = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: kLeftRightMarginOnBoarding,
                        ),
                        Column(
                          children: AppUtils().generateDynamicFields(
                              context,
                              _billerEntity != null
                                  ? _billerEntity.customFieldList
                                  : List.empty(), onRefresh: () {
                            setState(() {});
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kLeftRightMarginOnBoarding,
                    right: kLeftRightMarginOnBoarding,
                  ),
                  child: Column(
                    children: [
                      CDBBorderGradientButton(
                        width: double.maxFinite,
                        status: _isValidated()
                            ? ButtonStatus.ENABLE
                            : ButtonStatus.DISABLE,
                        onTap: () {
                          if (_customFieldValidated()) {
                            if(_customFieldRegexValidated()){
                              Navigator.pushNamed(
                                context,
                                Routes.kBillerAddConfirmView,
                                arguments: AddBillerArgs(
                                    nickName: nickName,
                                    customFields: _billerEntity.customFieldList,
                                    billerCategoryEntity: _billerCategoryEntity,
                                    billerEntity: _billerEntity),
                              );
                            }
                          } else {
                            ToastUtils.showCustomToast(context,
                                'Please fill all the fields', ToastStatus.fail);
                          }
                        },
                        text: AppString.save.localize(context),
                      ),
                      CDBNoBorderBackgroundButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: AppString.close.localize(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Validate
  bool _isValidated() {
    if (_billerCategoryEntity == null ||
        _billerEntity == null ||
        nickName == null ||
        nickName == "") {
      return false;
    }
    return true;
  }

  bool _customFieldValidated() {
    for (var element in _billerEntity.customFieldList) {
      if (element.userValue == null || element.userValue == '') {
        return false;
      }
    }

    return true;
  }

  bool _customFieldRegexValidated() {
    for (var element in _billerEntity.customFieldList) {
      if(element.customFieldDetailsEntity.fieldTypeEntity.name == fieldTypeTextField){
        if(element.customFieldDetailsEntity.validation!=null){
          if (!RegExp(element.customFieldDetailsEntity.validation.substring(
              1, element.customFieldDetailsEntity.validation.length - 1))
              .hasMatch(element.userValue)) {
            showCDBDialog(
              title: AppString.failed.localize(context),
              body: Column(
                children: [
                  Text('Invalid ${element.customFieldName}'),
                ],
              ),
              positiveButtonText: AppString.tryAgain.localize(context),
              positiveButtonTap: () {},
              negativeButtonText: '',
              negativeButtonTap: () {},
            );
            return false;
          }
        }else{
          return true;
        }
      }
    }

    return true;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
