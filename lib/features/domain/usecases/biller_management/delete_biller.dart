// ignore: directives_ordering
import 'package:cdb_mobile/features/domain/entities/request/delete_biller_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class DeleteBiller extends UseCase<BaseResponse, DeleteBillerEntity> {
  final Repository repository;

  DeleteBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(DeleteBillerEntity params) {
    return repository.deleteBiller(params);
  }
}
