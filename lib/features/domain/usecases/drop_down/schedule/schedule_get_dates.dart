import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/responses/schedule_date_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class GetScheduleDates extends UseCase<BaseResponse<ScheduleDateResponse>, GetScheduleParams> {
  final Repository repository;

  GetScheduleDates({this.repository});

  @override
  Future<Either<Failure, BaseResponse<ScheduleDateResponse>>> call(GetScheduleParams params) async {
    return await repository.getScheduleDates(params.scheduleDateRequest);
  }
}

class GetScheduleParams extends Equatable {
  final CommonRequestEntity scheduleDateRequest;

  const GetScheduleParams({@required this.scheduleDateRequest});

  @override
  List<Object> get props => [scheduleDateRequest];
}
