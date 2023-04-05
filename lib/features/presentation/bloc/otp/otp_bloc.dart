import 'package:cdb_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/otp/request_otp.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../domain/entities/request/challenge_request_entity.dart';
import '../../../domain/usecases/otp/verify_otp.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OTPBloc extends BaseBloc<OTPEvent, BaseState<OTPState>> {
  final VerifyOTP verifyOTP;
  final RequestOTP requestOTP;

  OTPBloc({this.verifyOTP, this.requestOTP}) : super(InitialOTPState());

  @override
  Stream<BaseState<OTPState>> mapEventToState(OTPEvent event) async* {
    if (event is OTPVerificationEvent) {
      yield APILoadingState();
      final deviceID = await FlutterUdid.consistentUdid;
      final _result = await verifyOTP(ChallengeRequestEntity(
          otpReferenceNo: event.otpReferenceNo,
          otpMessageType: event.otpMessageType,
          otp: event.otp,
          deviceId: deviceID,
          messageType: kMessageTypeChallengeReq));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return OTPVerificationFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return OTPVerificationSuccessState();
      });
    } else if (event is RequestOTPEvent) {
      yield APILoadingState();
      final _result = await requestOTP(const CommonRequestEntity(
        messageType: kOTPRequestType,
      ));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return OTPRequestFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return OTPRequestSuccessState(
          otpReferenceNo: r.data.data.otpReferenceNo,
          mobile: r.data.data.mobile,
          email: r.data.data.email,
        );
      });
    }
  }
}
