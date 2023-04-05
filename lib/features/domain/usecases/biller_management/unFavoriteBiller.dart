// ignore: directives_ordering
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/un_favorite_biller_entity.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class UnFavoriteBiller extends UseCase<BaseResponse, UnFavoriteBillerEntity> {
  final Repository repository;

  UnFavoriteBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(UnFavoriteBillerEntity params) {
    return repository.unFavoriteBiller(params);
  }
}
