import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
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

class PayeeDetails extends BaseView {
  final SavedPayeeEntity payeeDetails;
  const PayeeDetails({this.payeeDetails});
  @override
  State<PayeeDetails> createState() => _PayeeDetailsState();
}

class _PayeeDetailsState extends BaseViewState<PayeeDetails> {
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
                  field2: "Bank Name",
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
                  Navigator.of(context).pushNamed(Routes.kEditPayeeView,
                      arguments: widget.payeeDetails);
                  },
                  text: AppString.edit.localize(context),
                ),
                CDBNoBorderBackgroundButton(
                  onTap: () {
                    showCDBDialog(
                      alertImagePath: AppImages.icAlertConfirm,
                      title: 'Delete Payee',
                      body: Column(
                        children: const [
                          Text(
                            'Are you sure you want to delete this payee?',
                          ),
                        ],
                      ),
                      positiveButtonText: 'Yes, Delete',
                      positiveButtonTap: () {
                        //TODO : Implement the payee delete process.
                      },
                      isTwoButton: true,
                      negativeButtonText: 'Cancel',
                      negativeButtonTap: () {},
                    );
                  },
                  text: AppString.delete.localize(context),
                ),
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
