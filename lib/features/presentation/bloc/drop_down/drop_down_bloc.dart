import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/models/requests/get_schedule_time_request.dart';
import 'package:cdb_mobile/features/data/models/responses/schedule_date_response.dart';
import 'package:cdb_mobile/features/data/models/responses/sec_question_response.dart';
import 'package:cdb_mobile/features/domain/usecases/drop_down/designation/get_designation_data.dart';
import 'package:cdb_mobile/features/domain/usecases/drop_down/schedule/schedule_get_time.dart';
import 'package:cdb_mobile/features/domain/usecases/security_questions/get_security_questions.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_utils.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../../utils/app_constants.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/usecases/drop_down/city/get_city_data.dart';
import '../../../domain/usecases/drop_down/schedule/schedule_get_dates.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'drop_down_event.dart';
import 'drop_down_state.dart';

class DropDownBloc extends BaseBloc<DropDownEvent, BaseState<DropDownState>> {
  final GetCityData useCaseCityData;
  final GetDesignationData useCaseDesignationData;
  final GetScheduleDates getScheduleDates;
  final GetScheduleTime getScheduleTime;
  final GetSecurityQuestions useCaseGetQuestions;

  DropDownBloc(
      {this.useCaseCityData,
      this.useCaseDesignationData,
      this.getScheduleDates,
      this.getScheduleTime,
      this.useCaseGetQuestions})
      : super(InitialDropDownState());

  @override
  Stream<BaseState<DropDownState>> mapEventToState(DropDownEvent event) async* {
    if (event is GetTitleDropDownEvent) {
      yield DropDownDataLoadedState(data: kTitleList);
    } else if (event is GetLanguageDropDownEvent) {
      yield DropDownDataLoadedState(data: kLanguageList);
    } else if (event is GetReligionDropDownEvent) {
      yield DropDownDataLoadedState(data: kReligionList);
    } else if (event is GetEmpTypeDropDownEvent) {
      yield DropDownDataLoadedState(data: kCustomerType);
    } else if (event is GetEmpFieldDropDownEvent) {
      yield DropDownDataLoadedState(data: kFieldOfEmployment);
    } else if (event is GetBillerCategoriesDropDownEvent) {
      yield DropDownDataLoadedState(data: kBillerCategoryList);
    } else if (event is GetBillerListDropDownEvent) {
      yield DropDownDataLoadedState(data: kBillerList);
    } else if (event is GetCustomDropDownEvent) {
      yield DropDownDataLoadedState(
          data: event.dataList
              .map((e) => CommonDropDownResponse(description: e))
              .toList());
    } else if (event is GetCityDropDownEvent) {
      yield APILoadingState();

      final response = await useCaseCityData(
        const Params(
          commonRequestEntity: CommonRequestEntity(
            messageType: kGetCityRequestType,
          ),
        ),
      );

      yield* _eitherCitySuccessOrErrorState(response);
    } else if (event is GetEmpDesignation) {
      yield APILoadingState();

      final response = await useCaseDesignationData(
        const Parameter(
          commonRequestEntity: CommonRequestEntity(
            messageType: kGetDesignationRequestType,
          ),
        ),
      );

      yield* _eitherDesignationSuccessOrErrorState(response);
    } else if (event is GetAnnualIncome) {
      yield DropDownDataLoadedState(data: kMonthlyIncome);
    } else if (event is GetSecurityQuestionDropDownEvent) {
      yield APILoadingState();
      final _result = await useCaseGetQuestions(const CommonRequestEntity(
          messageType: kMessageTypeSecurityQuestionReq));
      yield* _eitherSecurityQuestionsSuccessOrErrorState(_result);
    } else if (event is GetPurposeOfAccountDropDownEvent) {
      yield DropDownDataLoadedState(data: kAccountPurpose);
    } else if (event is GetSourceOfFundsDropDownEvent) {
      yield DropDownDataLoadedState(data: kSourceOfFunds);
    } else if (event is GetTransactionModeDropDownEvent) {
      yield DropDownDataLoadedState(data: kTransactionMode);
    } else if (event is FilterEvent) {
      final List<CommonDropDownResponse> dropDownData = event.dropDownData;
      if (event.searchText == "" || event.searchText == null) {
        yield DropDownDataLoadedState(data: dropDownData);
      }
      List<CommonDropDownResponse> filteredList;
      filteredList = dropDownData
          .where((element) =>
              element.description.toLowerCase().startsWith(event.searchText.toLowerCase()))
          .toList();
      yield DropDownFilteredState(data: filteredList);
    } else if (event is GetScheduleDatesDropDownEvent) {
      yield APILoadingState();

      final response = await getScheduleDates(
        const GetScheduleParams(
          scheduleDateRequest: CommonRequestEntity(
            messageType: kScheduleDatesRequestType,
          ),
        ),
      );

      yield* _eitherScheduleDatesSuccessOrErrorState(response);
    } else if (event is GetScheduleTimeSlotDropDownEvent) {
      yield APILoadingState();

      final response = await getScheduleTime(
        GetScheduleTimeRequest(
            messageType: kScheduleTimeRequestType, date: event.selectedDate),
      );

      yield response.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return DropDownFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return DropDownDataLoadedState(
            data: r.data.timeSlots
                .map(
                  (e) => CommonDropDownResponse(
                    description: AppUtils.convert24Hto12(e),
                    id: r.data.timeSlots.indexOf(e),
                  ),
                )
                .toList());
      });
    }
  }

  /// Either Designation Success or Error
  Stream<BaseState<DropDownState>> _eitherDesignationSuccessOrErrorState(
    Either<Failure, BaseResponse> failureOrSplashSuccess,
  ) async* {
    final obj = failureOrSplashSuccess.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is! Failure) {
      final BaseResponse baseResponse = obj as BaseResponse;
      final CityDetailResponse designationDetailResponse = baseResponse.data;
      yield DropDownDataLoadedState(data: designationDetailResponse.data);
    } else {
      final ServerFailure serverFailure = obj as ServerFailure;
      yield DropDownFailedState(
          message: serverFailure.errorResponse.errorDescription);
    }
  }

  /// Either City Success or Error
  Stream<BaseState<DropDownState>> _eitherCitySuccessOrErrorState(
    Either<Failure, BaseResponse> failureOrSplashSuccess,
  ) async* {
    final obj = failureOrSplashSuccess.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is! Failure) {
      final BaseResponse baseResponse = obj as BaseResponse;
      final CityDetailResponse cityDetailResponse = baseResponse.data;
      yield DropDownDataLoadedState(data: cityDetailResponse.data);
    } else {
      final ServerFailure serverFailure = obj as ServerFailure;
      yield DropDownFailedState(
          message: serverFailure.errorResponse.errorDescription);
    }
  }

  /// Either Schedule Dates Success or Error
  Stream<BaseState<DropDownState>> _eitherScheduleDatesSuccessOrErrorState(
    Either<Failure, BaseResponse> failureOrSplashSuccess,
  ) async* {
    final obj = failureOrSplashSuccess.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is! Failure) {
      final BaseResponse baseResponse = obj as BaseResponse;
      final ScheduleDateResponse scheduleDateResponse = baseResponse.data;
      yield DropDownDataLoadedState(
          data: scheduleDateResponse.dates
              .map(
                (e) => CommonDropDownResponse(
                  description: e,
                  id: scheduleDateResponse.dates.indexOf(e),
                ),
              )
              .toList());
    } else {
      final ServerFailure serverFailure = obj as ServerFailure;
      yield DropDownFailedState(
          message: serverFailure.errorResponse.errorDescription);
    }
  }

  Stream<BaseState<DropDownState>> _eitherSecurityQuestionsSuccessOrErrorState(
    Either<Failure, BaseResponse<SecurityQuestionResponse>> result,
  ) async* {
    yield result.fold((l) {
      if (l is AuthorizedFailure) {
        return SessionExpireState();
      } else {
        return DropDownFailedState(
            message: ErrorMessages().mapFailureToMessage(l));
      }
    }, (r) {
      return DropDownDataLoadedState(
          data: r.data.data
              .map(
                (e) => CommonDropDownResponse(
                  description: e.description,
                  id: e.id,
                ),
              )
              .toList());
    });
  }
}
