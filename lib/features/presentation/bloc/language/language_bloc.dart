import 'package:cdb_mobile/features/domain/usecases/language/save_language.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../domain/entities/request/language_entity.dart';
import '../../../domain/usecases/language/set_language.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, BaseState<LanguageState>> {
  final SetPreferredLanguage setPreferredLanguage;
  final SavePreferredLanguage savePreferredLanguage;

  LanguageBloc({this.setPreferredLanguage, this.savePreferredLanguage})
      : super(InitialLanguageState());

  @override
  Stream<BaseState<LanguageState>> mapEventToState(LanguageEvent event) async* {
    if (event is SetPreferredLanguageEvent) {
      yield APILoadingState();
      final _result = await setPreferredLanguage(LanguageEntity(
        selectedDate: event.selectedDate,
        messageType: kLanguageRequestType,
        language: event.language,
      ));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return SetPreferredLanguageFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return SetPreferredLanguageSuccessState();
      });
    } else if (event is SavePrefLanguageStateEvent) {
      final _result = await savePreferredLanguage(NoParams());

      yield _result.fold((l) {
        return SavePrefLanguageFailedState(
            message: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        return SavePrefLanguageSuccessState();
      });
    }
  }
}
