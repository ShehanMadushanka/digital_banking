import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/repositories/repository.dart';
import 'package:cdb_mobile/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class StoreWalletOnBoardingData extends UseCase<bool, Parameter> {
  final Repository repository;

  StoreWalletOnBoardingData({this.repository});

  @override
  Future<Either<Failure, bool>> call(Parameter parameter) async {
    return repository
        .storeWalletOnBoardingData(parameter.walletOnBoardingDataEntity);
  }
}

class Parameter extends Equatable {
  final WalletOnBoardingDataEntity walletOnBoardingDataEntity;

  const Parameter({@required this.walletOnBoardingDataEntity});

  @override
  List<Object> get props => [walletOnBoardingDataEntity];
}
