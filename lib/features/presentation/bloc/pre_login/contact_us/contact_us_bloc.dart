import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../domain/entities/request/contact_us_request_entity.dart';
import '../../../../domain/usecases/contact_us/contact_us.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactUsBloc
    extends BaseBloc<ContactUsParentEvent, BaseState<ContactUsState>> {
  final ContactUs contactUs;

  ContactUsBloc({this.contactUs}) : super(InitialContactUsState());

  @override
  Stream<BaseState<ContactUsState>> mapEventToState(
      ContactUsParentEvent event) async* {
    if (event is ContactUsEvent) {
      yield APILoadingState();
      final _result = await contactUs(const ContactUsRequestEntity(
        messageType: kContactUsRequestType,
      ));

      if (_result.isRight()) {
        yield _result.fold(
            (l) => ContactUsFailedState(
                message: ErrorMessages().mapFailureToMessage(l)),
            (r) => ContactUsSuccessState(
                  companyName: r.data.companyName,
                  telNo: r.data.telNo,
                  email: r.data.email,
                  busAddLine1: r.data.busAddLine1,
                  busAddLine2: r.data.busAddLine2,
                  busAddLine3: r.data.busAddLine3,
                ));
      } else {
        yield ContactUsFailedState(
          message: ErrorMessages.errorSomethingWentWrong,
        );
      }
    }
  }
}