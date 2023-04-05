import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/requests/change_password_request.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class ChangePassword extends UseCase<BaseResponse,
    ChangePasswordRequest> {
  final Repository repository;

  ChangePassword({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      ChangePasswordRequest changePasswordRequest) async {
    return repository.changePassword(changePasswordRequest);
  }
}
