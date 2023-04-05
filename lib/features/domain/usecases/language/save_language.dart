import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../repositories/repository.dart';
import '../usecase.dart';

class SavePreferredLanguage extends UseCase<bool, NoParams> {
  final Repository repository;

  SavePreferredLanguage({this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async =>
      repository.savePreferredLanguage();
}
