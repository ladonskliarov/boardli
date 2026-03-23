import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authorization/domain/entities/company_entity.dart';
import '../../../authorization/domain/repositories/company_repository.dart';

part 'company_account_state.dart';

class CompanyAccountCubit extends Cubit<CompanyAccountState> {
  final CompanyRepository companyRepository;
  CompanyAccountCubit(this.companyRepository) : super(CompanyAccountInitial());

  Future<void> loadCompanyAccount() async {
    emit(CompanyAccountLoading());
    final result = await companyRepository.getMe();
    result.fold(
      (failure) => emit(CompanyAccountFailure(failure.message)),
      (company) => emit(CompanyAccountLoaded(company)),
    );
  }
}
