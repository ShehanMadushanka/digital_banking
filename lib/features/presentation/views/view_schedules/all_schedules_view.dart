import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/payee_management/payee_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/views/common/empty_view.dart';
import 'package:cdb_mobile/features/presentation/views/view_schedules/widget/cdb_schedules_bottom_app_bar.dart';
import 'package:cdb_mobile/features/presentation/views/view_schedules/widget/schedule_item.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';

class SchedulesEntity {
  final String title;
  final String fromAccount;
  final String toAccount;
  final String amount;
  final String startedDate;
  final String frequency;
  final String endDate;
  final int noOfTransfers;
  final String deletedDate;
  final String beneficiaryEmail;
  final String beneficiaryMobileNumber;

  SchedulesEntity(
      {this.title,
      this.amount,
      this.fromAccount,
      this.toAccount,
      this.startedDate,
      this.frequency,
      this.endDate,
      this.noOfTransfers,
      this.deletedDate,
      this.beneficiaryEmail,
      this.beneficiaryMobileNumber});
}

class AllSchedulesView extends BaseView {
  AllSchedulesView({Key key}) : super(key: key);

  @override
  State<AllSchedulesView> createState() => _AllSchedulesViewState();
}

class _AllSchedulesViewState extends BaseViewState<AllSchedulesView> {
  final PayeeManagementBloc _bloc = inject<PayeeManagementBloc>();

  List<SchedulesEntity> _scheduleTypes = [];

  int _selectedIndex = 0;

  void changeIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        if (_selectedIndex == 1 || _selectedIndex == 2) {
          _scheduleTypes.clear();
        } else {
          _addMockData();
        }
      });
    }
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Ongoing Schedules';
      case 1:
        return 'Upcoming Schedules';
      case 2:
        return 'Completed Schedules';
      case 3:
        return 'Deleted Schedules';
      default:
        return 'Schedules';
    }
  }

  @override
  void initState() {
    super.initState();
    _addMockData();
  }

  _addMockData() {
    _scheduleTypes.addAll([
      SchedulesEntity(
        title: 'University Fees',
        deletedDate: '12-Jun-2022',
        amount: '15,000',
        endDate: '08-Jan-2023',
        fromAccount: '',
        noOfTransfers: 12,
        toAccount: '',
        startedDate: '08-Jan-2022',
        frequency: 'Monthly',
      ),
      SchedulesEntity(
        title: 'Monthly Medicine',
        deletedDate: '12-Jun-2022',
        amount: '20,000',
        endDate: '08-Jan-2023',
        fromAccount: '',
        noOfTransfers: 3,
        toAccount: '',
        startedDate: '08-Jan-2022',
        frequency: 'Monthly',
      ),
      SchedulesEntity(
        title: 'Accommodation Fee',
        deletedDate: '12-Jun-2022',
        amount: '30,000',
        endDate: '08-Jan-2023',
        fromAccount: '',
        noOfTransfers: 5,
        toAccount: '',
        startedDate: '08-Jan-2022',
        frequency: 'Monthly',
      ),
    ]);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: _getTitle(),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: _scheduleTypes.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(
                  top: kOnBoardingMarginBetweenFields,
                  bottom: kBottomMargin,
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _scheduleTypes.length,
                itemBuilder: (_, index) => ScheduleItem(
                  schedule: _scheduleTypes[index],
                  onTapDelete: (schedule) {
                    showCDBDialog(
                      title: AppString.titleDeleteSchedule.localize(context),
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.descriptionDeleteSchedule
                              .localize(context)),
                          const SizedBox(
                            height: 16,
                          ),
                          Text.rich(
                            TextSpan(
                              text: AppString.noteDeleteSchedule
                                  .localize(context),
                              style: AppStyling.normal500Size14
                                  .copyWith(color: AppColors.primaryColor),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: AppString.noteDescriptionDeleteSchedule
                                      .localize(context),
                                  style: AppStyling.light300Size13
                                      .copyWith(color: AppColors.textDarkColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      isTwoButton: true,
                      alertImagePath: AppImages.icAlertConfirm,
                      positiveButtonText:
                          AppString.buttonYesDelete.localize(context),
                      positiveButtonTap: () {
                        _scheduleTypes.remove(schedule);
                        setState(() {});
                      },
                      negativeButtonText: AppString.no.localize(context),
                      negativeButtonTap: () {},
                    );
                  },
                ),
              ),
            )
          : CDBEmptyView(
              type: _selectedIndex == 0
                  ? EmptyViewType.NO_ONGOING_SCHEDULES
                  : (_selectedIndex == 1
                      ? EmptyViewType.NO_UPCOMING_SCHEDULES
                      : _selectedIndex == 2
                          ? EmptyViewType.NO_COMPLETED_SCHEDULES
                          : EmptyViewType.NO_DELETED_SCHEDULES)),
      bottomNavigationBar: CDBSchedulesBottomAppBar(
        onTapOne: () {
          changeIndex(0);
        },
        onTapThree: () {
          changeIndex(2);
        },
        onTapTwo: () {
          changeIndex(1);
        },
        onTapFour: () {
          changeIndex(3);
        },
        iconOne: CDBIcons.ic_ongoing,
        iconTwo: CDBIcons.ic_upcoming,
        iconThree: Icons.add_circle,
        iconFour: Icons.delete_outlined,
        iconNameOne: 'Ongoing',
        iconNameThree: 'Completed',
        iconNameTwo: 'Upcoming',
        iconNameFour: 'Deleted',
        inkWell: true,
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
