import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/requests/submit_products_request.dart';
import 'package:cdb_mobile/features/data/models/responses/submit_other_products_response.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SubmitOtherProducts
    extends UseCase<BaseResponse<SubmitProductsResponse>, Params> {
  final Repository repository;

  SubmitOtherProducts({this.repository});

  @override
  Future<Either<Failure, BaseResponse<SubmitProductsResponse>>> call(
      Params params) async {
    return await repository.submitOtherProducts(params.submitProductsRequest);
  }
}

class Params extends Equatable {
  final SubmitProductsRequest submitProductsRequest;

  const Params({@required this.submitProductsRequest});

  @override
  List<Object> get props => [submitProductsRequest];
}
