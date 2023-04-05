import 'package:cdb_mobile/features/data/models/responses/forgot_pw_reset_security_questions_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/forgot_pw_reset_security_questions_request_entity.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class GetForgotPwResetSecQuestions extends UseCase<
    BaseResponse<ForgotPwResetSecQuestionsResponseModel>,
    ForgotPwResetSecQuestionsRequestEntity> {
  final Repository repository;

  GetForgotPwResetSecQuestions({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ForgotPwResetSecQuestionsResponseModel>>> call(
      ForgotPwResetSecQuestionsRequestEntity params) async {
    return repository.getForgotPwResetSecQuestions(params);
  }
}
