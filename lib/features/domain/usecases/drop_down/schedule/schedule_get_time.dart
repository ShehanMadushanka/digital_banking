import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/requests/get_schedule_time_request.dart';
import 'package:cdb_mobile/features/data/models/responses/get_schedule_time_response.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetScheduleTime extends UseCase<BaseResponse<GetScheduleTimeResponse>,
    GetScheduleTimeRequest> {
  final Repository repository;

  GetScheduleTime({this.repository});

  @override
  Future<Either<Failure, BaseResponse<GetScheduleTimeResponse>>> call(
      GetScheduleTimeRequest params) async {
    return await repository.getScheduleTimeSlot(params);
  }
}
