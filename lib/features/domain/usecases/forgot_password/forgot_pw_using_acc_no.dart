import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/check_acc_no_nic_request.dart';
import '../../../data/models/responses/check_acc_no_nic_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class ForgotPwUsingAccountNumber extends UseCase<
    BaseResponse<CheckAccountNoNicResponse>, CheckAccountNoNicRequest> {
  final Repository repository;

  ForgotPwUsingAccountNumber({this.repository});

  @override
  Future<Either<Failure, BaseResponse<CheckAccountNoNicResponse>>> call(
      CheckAccountNoNicRequest params) async {
    return repository.checkAccountNumberNIC(params);
  }
}
