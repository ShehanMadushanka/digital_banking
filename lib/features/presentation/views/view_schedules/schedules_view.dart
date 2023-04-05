import 'package:cdb_mobile/features/presentation/views/view_schedules/widget/schedule_types_component.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

class SchedulesView extends StatelessWidget {
  SchedulesView({Key key}) : super(key: key);

  List<String> _scheduleTypes = [
    'Fund Transfer',
    'Bill Payment',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: 'Schedules',
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
                itemBuilder: (_, index) => ScheduleTypesComponent(
                    type: _scheduleTypes[index],
                    onTap: () {
                      Navigator.pushNamed(context, Routes.kAllSchedulesView);
                    }),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
