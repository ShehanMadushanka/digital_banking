import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_state.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_scrollview.dart';
import '../../base_view.dart';
import '../data/add_biller_args.dart';

class AddBillerConfirmView extends BaseView {
  final AddBillerArgs addBillerArgs;

  const AddBillerConfirmView({Key key, this.addBillerArgs}) : super(key: key);

  @override
  _AddBillerConfirmViewState createState() => _AddBillerConfirmViewState();
}

class _AddBillerConfirmViewState extends BaseViewState<AddBillerConfirmView> {
  /// Dependency Injection
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  @override
  void initState() {
    super.initState();
    widget.addBillerArgs.customFields.forEach((element) {
      element.customFieldDetailsEntity.fieldTypeEntity.name =
          fieldTypeOneLineLabelField;
    });
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleBillPaymentStatus.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {
            if (state is AddBillerSuccessState) {
              ToastUtils.showCustomToast(
                  context,
                  AppString.billerAddeddSuccessfully.localize(context),
                  ToastStatus.success);

              Navigator.pop(context);
              Navigator.pop(context);
            } else if (state is AddBillerFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.billerCategory.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Text(
                              widget.addBillerArgs.billerCategoryEntity
                                  .categoryName,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.billerName.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Text(
                              widget.addBillerArgs.billerEntity.billerName,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.nickName.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Text(
                              widget.addBillerArgs.nickName,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),
                        Column(
                          children: AppUtils().generateDynamicFields(
                              context, widget.addBillerArgs.customFields,
                              fieldType: fieldTypeOneLineLabelField),
                        )
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
                        onTap: () {
                          _bloc.add(
                            AddBillerEvent(
                                nickName: widget.addBillerArgs.nickName,
                                serviceProviderId:
                                    widget.addBillerArgs.billerEntity.billerId,
                                customFields:
                                    widget.addBillerArgs.customFields),
                          );
                        },
                        text: AppString.confirm.localize(context),
                      ),
                      CDBNoBorderBackgroundButton(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
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
