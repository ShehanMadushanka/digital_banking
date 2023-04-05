import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../entities/request/common_request_entity.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class GetSplashData extends UseCase<BaseResponse, Params> {
  final Repository repository;

  GetSplashData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(Params params) async {
    return await repository.getSplash(params.splashRequest);
  }
}

class Params extends Equatable {
  final CommonRequestEntity splashRequest;

  const Params({@required this.splashRequest});

  @override
  List<Object> get props => [splashRequest];
}
