import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/company_entity.dart';
import '../../../domain/repositories/company_repository.dart';

part 'company_register_state.dart';

class CompanyRegisterCubit extends Cubit<CompanyRegisterState> {
  final CompanyRepository companyRepository;
  CompanyRegisterCubit({required this.companyRepository})
    : super(CompanyRegisterInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(CompanyRegisterLoading());
    final result = await companyRepository.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(CompanyRegisterFailure(message: failure.message)),
      (company) => emit(CompanyRegisterSuccess(company: company)),
    );
  }

  Future<void> register({
    required String name,
    required String industry,
    required String size,
    required String contactName,
    required String email,
    required String password,
  }) async {
    emit(CompanyRegisterLoading());
    final result = await companyRepository.register(
      name: name,
      industry: industry,
      size: size,
      contactName: contactName,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(CompanyRegisterFailure(message: failure.message)),
      (company) => emit(CompanyRegisterSuccess(company: company)),
    );
  }
}
