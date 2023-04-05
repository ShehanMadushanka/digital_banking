import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_other_products_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class GetOtherProducts
    extends UseCase<BaseResponse<GetOtherProductsResponse>, Parameters> {
  final Repository repository;

  GetOtherProducts({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetOtherProductsResponse>>> call(
      Parameters params) async {
    return await repository.getOtherProducts(params.otherProductRequest);
  }
}

class Parameters extends Equatable {
  final CommonRequestEntity otherProductRequest;

  const Parameters({@required this.otherProductRequest});

  @override
  List<Object> get props => [otherProductRequest];
}
