import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_biller_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../bloc/biller_management/biller_management_event.dart';
import '../../bloc/biller_management/biller_management_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class EditBillerConfirmView extends BaseView {
  final SavedBillerEntity savedBillerEntity;

  const EditBillerConfirmView({Key key, this.savedBillerEntity})
      : super(key: key);

  @override
  _EditBillerConfirmViewState createState() => _EditBillerConfirmViewState();
}

class _EditBillerConfirmViewState extends BaseViewState<EditBillerConfirmView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  @override
  void initState() {
    super.initState();
  }

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
            if (state is EditUserBillerSuccessState) {
              ToastUtils.showCustomToast(
                  context,
                  AppString.nickNameEditedSuccessfully.localize(context),
                  ToastStatus.success);

              Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.kSavedBillerListView,
                  ModalRoute.withName(Routes.kQuickAccessMenu));
            } else if (state is EditUserBillerFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            }
          },
          child: Container(
            width: double.infinity,
            color: AppColors.whiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: kTopMarginOnBoarding,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: Icon(
                                        widget.savedBillerEntity.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.textLightColor,
                                          width: 0.5),
                                      color: AppColors.whiteColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.2,
                                          blurRadius:
                                              7, // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width: 150,
                                    height: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Image.network(
                                        widget.savedBillerEntity.serviceProvider
                                            .billerImage,
                                        width: 50.w,
                                        height: 50.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.only(
                          left: kLeftRightMarginOnBoarding,
                          right: kLeftRightMarginOnBoarding,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppString.billerCategory.localize(context),
                                  style: AppStyling.normal400Size14.copyWith(
                                      color: AppColors.textTitleColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    widget.savedBillerEntity.billerCategory
                                        .categoryName,
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppString.serviceProvider.localize(context),
                                  style: AppStyling.normal400Size14.copyWith(
                                      color: AppColors.textTitleColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    widget.savedBillerEntity.serviceProvider
                                        .billerName,
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textLightColor),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppString.nickname.localize(context),
                                  style: AppStyling.normal400Size14.copyWith(
                                      color: AppColors.textTitleColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    widget.savedBillerEntity.nickName,
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: AppUtils().generateDynamicFields(
                                    context,
                                    widget.savedBillerEntity
                                            .customFieldEntityList ??
                                        List.empty(),
                                    fieldType: fieldTypeLableField,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        onTap: () {
                          _bloc.add(
                            EditUserBillerEvent(
                              nickName: widget.savedBillerEntity.nickName,
                              serviceProviderId: widget
                                  .savedBillerEntity.serviceProvider.billerId
                                  .toString(),
                              fieldList: widget
                                  .savedBillerEntity.customFieldEntityList,
                              billerId: widget.savedBillerEntity.id,
                              categoryId: widget
                                  .savedBillerEntity.billerCategory.categoryId
                                  .toString(),
                            ),
                          );
                        },
                        text: AppString.confirm.localize(context),
                      ),
                      CDBNoBorderBackgroundButton(
                        onTap: () {
                          showCDBDialog(
                            isTwoButton: true,
                            title: AppString.cancelEdit.localize(context),
                            body: Column(
                              children: [
                                Text(
                                    AppString.cancelEditDesc.localize(context)),
                              ],
                            ),
                            positiveButtonText:
                                AppString.yesCancel.localize(context),
                            positiveButtonTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kSavedBillerListView);
                            },
                            negativeButtonText: AppString.no.localize(context),
                            negativeButtonTap: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        text: AppString.cancel.localize(context),
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
