import 'package:cdb_mobile/features/data/models/requests/submit_schedule_data_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../data/models/common/base_response.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class SubmitScheduleData
    extends UseCase<BaseResponse, SubmitScheduleDataRequest> {
  final Repository repository;

  SubmitScheduleData({this.repository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      SubmitScheduleDataRequest params) async {
    return repository.submitScheduleData(params);
  }
}
