import 'package:cdb_mobile/features/data/models/requests/schedule_verification_request.dart';

import '../../base_event.dart';

abstract class ScheduleVerificationEvent extends BaseEvent {}

/// Get Schedule Information
class GetScheduleInformationEvent extends ScheduleVerificationEvent {}

/// Store Schedule Information
class StoreScheduleVerificationInformationEvent
    extends ScheduleVerificationEvent {
  final int stepValue;
  final String stepName;
  final ScheduleVerificationRequest scheduleVerificationRequest;
  final bool isBackButtonClick;

  StoreScheduleVerificationInformationEvent(
      {this.scheduleVerificationRequest,
      this.stepName,
      this.stepValue,
      this.isBackButtonClick});
}

/// Store And Navigate
class SubmitScheduleDataEvent extends ScheduleVerificationEvent {
  final String language;
  final String date;
  final String timeSlot;

  SubmitScheduleDataEvent({
    this.language,
    this.date,
    this.timeSlot,
  });
}
