import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_no_border_background_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_scrollview.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

class EditScheduleView extends StatefulWidget {
  const EditScheduleView({Key key}) : super(key: key);

  @override
  State<EditScheduleView> createState() => _EditScheduleViewState();
}

class _EditScheduleViewState extends State<EditScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: 'Edit Schedules',
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: kBottomMargin,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CDBScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Paid From',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'My CDB Savings',
                                      style: AppStyling.normal600Size14
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '0000123456',
                                      style: AppStyling.light300Size13.copyWith(
                                          color: AppColors.textDarkColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Paid To',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'CDB Savings - Amma',
                                      style: AppStyling.normal600Size14
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '0000123457',
                                      style: AppStyling.light300Size13.copyWith(
                                          color: AppColors.textDarkColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Schedule Type',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  'One Time',
                                  style: AppStyling.normal600Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Schedule Title',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  'University Fees',
                                  style: AppStyling.normal600Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transaction Date',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  '18-Jul-2022',
                                  style: AppStyling.normal600Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transaction Category',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  'Education',
                                  style: AppStyling.normal600Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: 'Amount',
                                        style: AppStyling.normal400Size14
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                      TextSpan(
                                        text: ' (LKR)',
                                        style: AppStyling.normal500Size10
                                            .copyWith(
                                            color: AppColors.textDarkColor),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '50,000.00',
                                  style: AppStyling.normal600Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: CdbCustomTextField(
                              maxLength: 50,
                              labelText: 'Beneficiary Email',
                              onChange: (value) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: CdbCustomTextField(
                              maxLength: 10,
                              labelText: 'Beneficiary Mobile Number',
                              onChange: (value) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImages.iconInfoIc,
                                    width: 16, height: 16),
                                const SizedBox(
                                  width: 6,
                                ),
                                Flexible(
                                  child: Text(
                                    'If you want to edit more than beneficiary Email and Mobile No, Please delete this schedule and add a new schedule with preferred details.',
                                    style: AppStyling.normal400Size14.copyWith(
                                        color: AppColors.textDarkColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                          onTap: () async {},
                          text: AppString.save.localize(context),
                        ),
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
      }),
    );
  }
}
