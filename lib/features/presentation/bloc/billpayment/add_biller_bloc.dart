import 'package:cdb_mobile/features/presentation/bloc/billpayment/add_biller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_biller_event.dart';

class AddBillerBloc extends Bloc<AddBillerEvent, AddBillerState> {


  AddBillerBloc(AddBillerState initialState) : super(initialState);

  @override
  void onTransition(Transition<AddBillerEvent, AddBillerState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<AddBillerState> mapEventToState(AddBillerEvent event) async* {
    if (event is ConfirmBillerEvent) {
      yield AddBillerLoadingState();

      final u = event.username;
      final p = event.password;

      ///API call goes here
      final result = true;

      if(result){
        yield AddBillerSuccessState(true);
      } else {
        yield AddBillerFailedState();
      }

    } else {

    }
  }

}