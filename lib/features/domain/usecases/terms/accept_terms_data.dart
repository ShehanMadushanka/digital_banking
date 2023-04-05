import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/terms_accept_request_entity.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

import '../usecase.dart';

class AcceptTermsData extends UseCase<BaseResponse, TermsAcceptRequestEntity> {
  final Repository repository;

  AcceptTermsData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      TermsAcceptRequestEntity params) async {
    return repository.acceptTerms(params);
  }
}
