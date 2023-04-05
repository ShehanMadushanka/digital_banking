import 'package:flutter/material.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/language/language_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import 'widget/payee_details_textrow.dart';

class PayeeConfirmView extends BaseView {
  final SavedPayeeEntity payeeDetails;
  final bool isEditView;
  const PayeeConfirmView({this.payeeDetails,this.isEditView});
  @override
  State<PayeeConfirmView> createState() => _PayeeDetailsState();
}

class _PayeeDetailsState extends BaseViewState<PayeeConfirmView> {
  final _bloc = inject<LanguageBloc>();
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.payeeDetails.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: kTopMarginOnBoarding,
          left: kLeftRightMarginOnBoarding,
          right: kLeftRightMarginOnBoarding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // A custom text row widget.
                DetailsField(
                  field1: AppString.nickName.localize(context),
                  field2: widget.payeeDetails.nickName,
                ),
                // A custom text row widget.
                DetailsField(
                  field1: AppString.bank.localize(context),
                  field2: widget.payeeDetails.bankName,
                ),
                // A custom text row widget.
                DetailsField(
                  field1: AppString.accNumber.localize(context),
                  field2: widget.payeeDetails.accountNumber,
                ),
                // A custom text row widget.
                DetailsField(
                  field1: AppString.accHolderName.localize(context),
                  field2: widget.payeeDetails.accountHolderName,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.addedAsFavorite.localize(context),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff555454),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.payeeDetails.isFavorite)
                      const Icon(
                        Icons.favorite,
                        color: Color(0xff0078BF),
                        size: 25,
                      )
                    else
                      const Icon(
                        Icons.favorite_border,
                        size: 25,
                      ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                CDBBorderGradientButton(
                  width: double.maxFinite,
                  onTap: () {
                    //TODO : Implement the payee confirmation process.
                  },
                  text: AppString.confirm.localize(context),
                ),
                if(widget.isEditView)
                CDBNoBorderBackgroundButton(
                  onTap: () {
                    showCDBDialog(
                      alertImagePath: AppImages.icAlertConfirm,
                      title: 'Cancel the Edit Payee Process',
                      body: Column(
                        children: const [
                          Text(
                            'Are you sure you want to cancel this edit payee process?',
                          ),
                        ],
                      ),
                      positiveButtonText: 'Yes, Cancel',
                      positiveButtonTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.kHomeView, (route) => false);
                      },
                      isTwoButton: true,
                      negativeButtonText: 'No',
                      negativeButtonTap: () {},
                    );
                  },
                  text: AppString.cancel.localize(context),
                )else
                  CDBNoBorderBackgroundButton(
                  onTap: () {
                    showCDBDialog(
                      alertImagePath: AppImages.icAlertConfirm,
                      title: 'Cancel the Add Payee Process',
                      body: Column(
                        children: const [
                          Text(
                            'Are you sure you want to cancel this add payee process?',
                          ),
                        ],
                      ),
                      positiveButtonText: 'Yes, Cancel',
                      positiveButtonTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.kHomeView, (route) => false);
                      },
                      isTwoButton: true,
                      negativeButtonText: 'No',
                      negativeButtonTap: () {},
                    );
                  },
                  text: AppString.cancel.localize(context),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
