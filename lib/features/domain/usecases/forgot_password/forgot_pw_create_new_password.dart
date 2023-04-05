import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/forgot_pw_create_new_password_request_entity.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class ForgotPwCreateNewPassword
    extends UseCase<BaseResponse, ForgotPwCreateNewPasswordRequestEntity> {
  final Repository repository;

  ForgotPwCreateNewPassword({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      ForgotPwCreateNewPasswordRequestEntity params) async {
    return repository.forgotPwCreateNewPassword(params);
  }
}
