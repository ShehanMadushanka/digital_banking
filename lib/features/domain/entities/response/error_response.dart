import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ErrorResponse extends Equatable {
  final String errorCode;
  final String errorDescription;

  const ErrorResponse({
    @required this.errorCode,
    @required this.errorDescription
  });

  @override
  List<Object> get props => [errorCode, errorDescription];
}