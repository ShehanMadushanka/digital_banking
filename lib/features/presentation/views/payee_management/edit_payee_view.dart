import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/domain/entities/response/saved_payee_entity.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/payee_confirm_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/language/language_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../base_view.dart';

class EditPayeeView extends BaseView {
  final SavedPayeeEntity savedPayeeEntity;

  const EditPayeeView({this.savedPayeeEntity, Key key}) : super(key: key);

  @override
  _EditPayeeViewState createState() => _EditPayeeViewState();
}

class _EditPayeeViewState extends BaseViewState<EditPayeeView> {
  final _bloc = inject<LanguageBloc>();

  bool isFavoriteOption = false;
  String nikName;
  String accountNumber;
  String accountHolderName;
  bool saveEnableButton = true;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.editPayeeViewTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: kLeftRightMarginOnBoarding,
          right: kLeftRightMarginOnBoarding,
          top: 25,
          bottom: kBottomMargin,
        ),
        child: Column(
          children: [
            CdbCustomTextField(
              initialValue: widget.savedPayeeEntity.nickName,
              labelText: AppString.nickName.localize(context),
              onChange: (value) {
                setState(() {
                  widget.savedPayeeEntity.nickName = value;
                  checkFieldValidation();
                });
              },
            ),
            CdbDropDown(
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textDarkColor,
              ),
              labelText: AppString.bank.localize(context),
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  Routes.kDropDownView,
                  arguments: DropDownViewScreenArgs(
                    pageTitle: AppString.bank.localize(context),
                    isSearchable: true,
                    // dropDownEvent: GetLanguageDropDownEvent(),
                  ),
                ) /*as CommonDropDownResponse*/;

                if (result != null) {
                  setState(() {
                    // language = result.description;
                  });
                }
              },
            ),
            CdbCustomTextField(
              initialValue: widget.savedPayeeEntity.accountNumber,
              labelText: AppString.accNumber.localize(context),
              onChange: (value) {
                setState(() {
                  widget.savedPayeeEntity.accountNumber = value;
                  checkFieldValidation();
                });
              },
              textInputType: TextInputType.number,
            ),
            CdbCustomTextField(
              initialValue: widget.savedPayeeEntity.accountHolderName,
              labelText: AppString.accHolderName.localize(context),
              onChange: (value) {
                setState(() {
                  widget.savedPayeeEntity.accountHolderName = value;
                  checkFieldValidation();
                });
              },
            ),
            ListTileSwitch(
              contentPadding: EdgeInsets.zero,
              value: widget.savedPayeeEntity.isFavorite,
              onChanged: (value) {
                setState(() {
                  widget.savedPayeeEntity.isFavorite = value;
                });
              },
              switchActiveColor: AppColors.primaryColor,
              title: Text(
                AppString.addAsAFavorite.localize(context),
                style: AppStyling.normal400Size14
                    .copyWith(color: AppColors.textDarkColor),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                CDBBorderGradientButton(
                  status: saveEnableButton
                      ? ButtonStatus.ENABLE
                      : ButtonStatus.DISABLE,
                  width: double.maxFinite,
                  onTap: () {
                    debugPrint(
                        "$nikName  $accountNumber $accountHolderName $isFavoriteOption");
                    Navigator.of(context).pushNamed(Routes.kPayeeConfirmView,
                        arguments: PayeeConfirmView(
                          payeeDetails: widget.savedPayeeEntity,
                          isEditView: true,
                        ));
                  },
                  text: AppString.save.localize(context),
                ),
                CDBNoBorderBackgroundButton(
                  onTap: () {
                    showCDBDialog(
                      alertImagePath: AppImages.icAlertConfirm,
                      isTwoButton: true,
                      title: AppString.cancelEditPayeeTitle.localize(context),
                      body: Column(
                        children: [
                          Text(AppString.cancelEditPayeeDesc.localize(context)),
                        ],
                      ),
                      positiveButtonText: AppString.yesCancel.localize(context),
                      positiveButtonTap: () {
                        Navigator.pop(context);
                      },
                      negativeButtonText: AppString.no.localize(context),
                      negativeButtonTap: () {},
                    );
                  },
                  text: AppString.cancel.localize(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void checkFieldValidation() {
    if (widget.savedPayeeEntity.accountNumber.isNotEmpty &&
        widget.savedPayeeEntity.nickName.isNotEmpty &&
        widget.savedPayeeEntity.accountHolderName.isNotEmpty) {
      saveEnableButton = true;
    } else {
      saveEnableButton = false;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
