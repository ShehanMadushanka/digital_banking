import 'package:cdb_mobile/features/data/models/requests/edit_user_biller_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class EditUserBiller extends UseCase<BaseResponse,
    EditUserBillerRequest> {
  final Repository repository;

  EditUserBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      EditUserBillerRequest params) async {
    return repository.editBiller(params);
  }
}
