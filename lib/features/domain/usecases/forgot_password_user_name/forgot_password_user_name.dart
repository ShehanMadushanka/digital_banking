import 'package:cdb_mobile/features/data/models/responses/forgot_password_user_name_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/forgot_password_user_name_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class GetForgotPasswordUserName extends UseCase<
    BaseResponse<ForgotPasswordUserNameResponseModel>,
    ForgotPasswordUserNameRequestEntity> {
  final Repository repository;

  GetForgotPasswordUserName({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ForgotPasswordUserNameResponseModel>>> call(
      ForgotPasswordUserNameRequestEntity params) async {
    return await repository.getForgotPwUsername(params);
  }
}