import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_terms_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/get_terms_request_entity.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetTermsData
    extends UseCase<BaseResponse<GetTermsResponse>, GetTermsRequestEntity> {
  final Repository repository;

  GetTermsData({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetTermsResponse>>> call(
      GetTermsRequestEntity params) async {
    return repository.getTerms(params);
  }
}
