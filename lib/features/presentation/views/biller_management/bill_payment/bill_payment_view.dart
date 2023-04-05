import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/data/bill_payment_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../domain/entities/response/biller_category_entity.dart';
import '../../../../domain/entities/response/biller_entity.dart';
import '../../../../domain/entities/response/custom_field_entity.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/biller_management/biller_management_bloc.dart';
import '../../../bloc/biller_management/biller_management_state.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../base_view.dart';
import '../widget/bill_payment_account_card.dart';

class BillPaymentView extends BaseView {
  final BillerCategoryEntity billerCategoryEntity;
  final CustomFieldEntity customFieldEntity;
  final BillerEntity billerEntity;

  const BillPaymentView(
      {this.billerCategoryEntity, this.customFieldEntity, this.billerEntity});

  @override
  _BillPaymentViewState createState() => _BillPaymentViewState();
}

class _BillPaymentViewState extends State<BillPaymentView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  final List<String> items = ["a", "b", "c"];

  String mobileNumber;
  double amount;
  String remarks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleBillPayment.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 24.0),
                              child: Text(
                                AppString.payFrom.localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                            ),
                            SizedBox(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: CarouselSlider.builder(
                                itemCount: items.length,
                                itemBuilder: (
                                  BuildContext context,
                                  int itemIndex,
                                  int pageViewIndex,
                                ) =>
                                    BillPaymentAccountCard(
                                  title: "CDB Salary Plus",
                                  accountNumber: "0102000568215",
                                  amount: "520,000.00",
                                  onTap: () {},
                                ),
                                options: CarouselOptions(
                                  viewportFraction: 0.70,
                                  initialPage: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 20),
                              child: Text(
                                AppString.serviceProvider.localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24.0, top: 4.0),
                              child: Text(
                                widget.billerEntity.billerName,
                                style: AppStyling.normal500Size16
                                    .copyWith(color: AppColors.textDarkColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kLeftRightMarginOnBoarding,
                                  right: kLeftRightMarginOnBoarding),
                              child: Column(
                                children: AppUtils().generateDynamicFields(context,
                                    widget.billerEntity.customFieldList ??
                                        List.empty(),
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 24.0),
                              child: CdbCustomTextField(
                                labelText:
                                    AppString.amountLkr.localize(context),
                                textInputType: TextInputType.number,
                                initialValue: '',
                                onChange: (value) {
                                  setState(() {
                                    amount = value;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24.0, left: 16),
                              child: Text(
                                AppString.remarks.localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 5.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xFFE7E7E7), width: 2),
                                  ),
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
                                    Navigator.pushNamed(
                                        context, Routes.kBillPaymentSummaryView,
                                        arguments: BillPaymentArgs(
                                          amount: amount,
                                          billerEntity: widget.billerEntity,
                                          remark: remarks,
                                        ));
                                  },
                                  text: AppString.payNow.localize(context)),
                              CDBNoBorderBackgroundButton(
                                onTap: () {},
                                text: AppString.cancel.localize(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
