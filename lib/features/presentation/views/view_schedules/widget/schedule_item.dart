import 'package:cdb_mobile/features/presentation/views/view_schedules/all_schedules_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final Function(SchedulesEntity) onTapDelete;
  final SchedulesEntity schedule;

  const ScheduleItem({Key key, this.onTapDelete, this.schedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                schedule.title,
                style: AppStyling.normal600Size18
                    .copyWith(color: AppColors.textDarkColor),
              ),
              Text.rich(
                TextSpan(
                  text: "LKR ",
                  children: [
                    TextSpan(
                      text: schedule.amount,
                      style: AppStyling.normal600Size20
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    TextSpan(
                      text: '.00',
                      style: AppStyling.light300Size15
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                ),
                style: AppStyling.light300Size12
                    .copyWith(color: AppColors.textDarkColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '0000123456',
                      style: AppStyling.light300Size13
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '0000123457',
                      style: AppStyling.light300Size13
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Started Date',
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  schedule.startedDate,
                  style: AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Frequency',
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  schedule.frequency,
                  style: AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'End Date',
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  schedule.endDate,
                  style: AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. of Transfers',
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  '${schedule.noOfTransfers}',
                  style: AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deleted Date',
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  schedule.deletedDate,
                  style: AppStyling.normal600Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: true
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                CDBBorderGradientButton(
                  width: 150,
                  height: 30,
                  onTap: () {
                    Navigator.pushNamed(
                        context, Routes.kScheduleTransactionHistory);
                  },
                  text: 'Transaction History',
                ),
                true
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.kEditScheduleView);
                            },
                            child: Icon(
                              CDBIcons.ic_info_edit,
                              color: AppColors.accentColor,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () => onTapDelete(schedule),
                            child: Icon(
                              CDBIcons.ic_delete,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Divider(
            color: Color(0xffE7E7E7),
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
