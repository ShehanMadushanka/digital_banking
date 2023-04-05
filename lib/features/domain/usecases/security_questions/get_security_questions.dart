import 'package:cdb_mobile/features/data/models/responses/sec_question_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class GetSecurityQuestions extends UseCase<BaseResponse, CommonRequestEntity> {
  final Repository repository;

  GetSecurityQuestions({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SecurityQuestionResponse>>> call(
      CommonRequestEntity params) async {
    return repository.getSecurityQuestions(params);
  }
}
