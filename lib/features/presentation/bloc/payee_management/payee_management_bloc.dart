
import 'package:cdb_mobile/features/domain/entities/request/delete_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/favourite_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/un_favorite_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/saved_payee_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/delete_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/favourite_biller.dart';

import 'package:cdb_mobile/features/data/models/requests/edit_user_biller_request.dart';
import 'package:cdb_mobile/features/domain/entities/request/edit_user_biller_request_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/edit_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/unFavoriteBiller.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/models/requests/add_biller_request.dart';
import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/entities/response/biller_category_entity.dart';
import '../../../domain/entities/response/biller_entity.dart';
import '../../../domain/entities/response/charee_code_entity.dart';
import '../../../domain/entities/response/custom_field_entity.dart';
import '../../../domain/usecases/biller_management/add_biller.dart';
import '../../../domain/usecases/biller_management/get_biller_categories.dart';
import '../../../domain/usecases/biller_management/saved_billers.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'payee_management_event.dart';
import 'payee_management_state.dart';

class PayeeManagementBloc
    extends BaseBloc<PayeeManagementEvent, BaseState<PayeeManagementState>> {

  PayeeManagementBloc()
      : super(InitialPayeeManagementState());

  @override
  Stream<BaseState<PayeeManagementState>> mapEventToState(
      PayeeManagementEvent event) async* {
    if (event is GetSavedPayeesEvent) {
      yield GetSavedPayeesSuccessState(
        savedPayees: [
          SavedPayeeEntity(
            nickName: 'CDB Savings  - Malli',
            accountNumber: '0152642498',
            isFavorite: false,
            payeeImageUrl: 'https://www.cdb.lk/wp-content/uploads/2019/07/cdb-english.png',
            accountHolderName: 'Isuru Wipulasara',
            bankName: 'Commercial Bank',
          ),

          SavedPayeeEntity(
            nickName: 'CDB Savings - Amma',
            accountNumber: '0152642499',
            isFavorite: true,
            payeeImageUrl: 'https://www.cdb.lk/wp-content/uploads/2019/07/cdb-english.png',
            accountHolderName: 'Nileshi Kotelawala',
            bankName: 'BOC Bank',
          ),

          SavedPayeeEntity(
            nickName: 'CDB Savings - Thaththa',
            accountNumber: '0152644499',
            isFavorite: true,
            payeeImageUrl: 'https://www.cdb.lk/wp-content/uploads/2019/07/cdb-english.png',
            accountHolderName: 'Amarathunge Wijetunge',
            bankName: 'HND Bank',
          ),
        ]
      );
    }
  }
}
