import 'package:cdb_mobile/features/data/models/responses/otp_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/common_request_entity.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class RequestOTP extends UseCase<BaseResponse, CommonRequestEntity> {
  final Repository repository;

  RequestOTP({this.repository});

  @override
  Future<Either<Failure, BaseResponse<OTPResponse>>> call(
      CommonRequestEntity params) async {
    return repository.otpRequest(params);
  }
}
