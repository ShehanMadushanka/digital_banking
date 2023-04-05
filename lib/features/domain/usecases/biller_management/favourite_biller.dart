// ignore: directives_ordering
import 'package:cdb_mobile/features/domain/entities/request/favourite_biller_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class FavouriteBiller extends UseCase<BaseResponse, FavouriteBillerEntity> {
  final Repository repository;

  FavouriteBiller({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(FavouriteBillerEntity params) {
    return repository.favouriteBiller(params);
  }
}
