import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/domain/entities/response/account_entity.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_state.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/cdb_biller_bottom_app_bar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../base_view.dart';

class AccountDetailView extends BaseView {
  final AccountEntity accountEntity;

  AccountDetailView({this.accountEntity});

  @override
  _AccountDetailViewState createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends BaseViewState<AccountDetailView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  bool isPrimaryOption = true;
  bool hideFromPaymentOption = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleAddPaymentInstrumentRoot.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: Container(
            color: AppColors.whiteColor,
            child: Container(
              width: double.infinity,
              color: AppColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.textLightColor, width: 0.5),
                            color: AppColors.whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.2,
                                blurRadius: 7, // changes position of shadow
                              ),
                            ],
                          ),
                          width: 150,
                          height: 90,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              AppImages.cdbBankLogo,
                              width: 50.w,
                              height: 50.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (widget.accountEntity.isPrimary)
                          Text(
                            'Primary Account',
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textDarkColor),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.labelAccountNickName.localize(context),
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.accountEntity.nickName,
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppString.labelAccountNumber.localize(context),
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.accountEntity.accountNumber,
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                        ),
                        if (widget.accountEntity.isCDBAccount)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                AppString.labelTotalAvailableBalance
                                    .localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      "LKR ",
                                      style: AppStyling.normal500Size12
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              "${NumberFormat.currency(symbol: '').format(widget.accountEntity.availableBalance).split('.')[0]}.",
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor),
                                          children: [
                                            TextSpan(
                                              text: NumberFormat.currency(
                                                      symbol: '')
                                                  .format(widget.accountEntity
                                                      .availableBalance)
                                                  .split('.')[1],
                                              style: AppStyling.normal300Size15
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                        ListTileSwitch(
                          contentPadding: EdgeInsets.zero,
                          value: isPrimaryOption,
                          onChanged: (value) {
                            setState(() {
                              isPrimaryOption = value;
                              if (isPrimaryOption) {
                                hideFromPaymentOption = false;
                              }
                            });
                          },
                          switchActiveColor: AppColors.primaryColor,
                          title: Text(
                            AppString.labelPrimaryAccount.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                        ),
                        IgnorePointer(
                          ignoring: isPrimaryOption,
                          child: ListTileSwitch(
                            contentPadding: EdgeInsets.zero,
                            value: hideFromPaymentOption,
                            onChanged: (value) {
                              setState(() {
                                hideFromPaymentOption = value;
                              });
                            },
                            switchActiveColor: AppColors.primaryColor,
                            title: Text(
                              AppString.labelHideFromPaymentOptions
                                  .localize(context),
                              style: AppStyling.normal400Size14.copyWith(
                                  color: isPrimaryOption
                                      ? AppColors.darkAshColor
                                      : AppColors.textDarkColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CDBBillerBottomAppBar(
        onTapOne: () {
          Navigator.pushNamed(context, Routes.kEditAccountNicknameView,
              arguments: widget.accountEntity);
        },
        onTapThree: () {
          showCDBDialog(
            title: 'Delete Payment Instrument',
            body: Column(
              children: const [
                Text(
                    'Are you sure want to delete seclected payment instrument?'),
              ],
            ),
            positiveButtonText: 'Yes, Delete',
            positiveButtonTap: () {},
            isTwoButton: true,
            negativeButtonText: 'No',
            negativeButtonTap: () {},
          );
        },
        iconOne: CDBIcons.ic_info_edit,
        iconNameOne: 'Edit',
        iconNameThree: !widget.accountEntity.isCDBAccount ? 'Remove' : '',
        iconNameTwo: '',
        iconTwo: null,
        iconThree:
            !widget.accountEntity.isCDBAccount ? CDBIcons.ic_delete : null,
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
