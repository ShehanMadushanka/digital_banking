import 'failures.dart';

class ErrorMessages {
  ///error_title
  static const String title = "Error";

  ///error_messages
  static const String errorSomethingWentWrong = "Something went wrong!";
  static const String errorAppVerificationFailed = "App verification failed!";
  static const String errorMessage1 = "Entered Passwords are not match";
  static const String errorMessage2 = "Invalid details. Please enter correct username and password";
  static const String errorMessage3 = "Please Enter PIN";
  static const String errorMessageAlreadyExistingNIC = "NIC already exits";

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectionFailure:
        return 'No internet connection detected.';
      case ServerFailure:
        return (failure as ServerFailure).errorResponse.errorDescription;
      case AuthorizedFailure:
        return (failure as AuthorizedFailure).errorResponse.errorDescription;
      default:
        return 'Unexpected error';
    }
  }
}