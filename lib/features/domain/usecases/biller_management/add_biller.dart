// ignore: directives_ordering
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/add_biller_request.dart';
import '../../../data/models/responses/add_biller_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class AddBiller
    extends UseCase<BaseResponse<AddBillerResponse>, AddBillerRequest> {
  final Repository repository;

  AddBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse<AddBillerResponse>>> call(
      AddBillerRequest params) {
    return repository.addBiller(params);
  }
}
