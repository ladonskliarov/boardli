import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/resource.dart';
import '../../domain/repositories/knowledge_base_repository.dart';

part 'knowledge_base_state.dart';

class KnowledgeBaseCubit extends Cubit<KnowledgeBaseState> {
  final KnowledgeBaseRepository repository;
  KnowledgeBaseCubit({required this.repository}) : super(KnowledgeBaseInitial());

  Future<void> getResources() async {
    emit(KnowledgeBaseLoading());
    final result = await repository.getResources();

    result.fold(
      (failure) => emit(KnowledgeBaseFailure(message: failure.message)),
      (resources) => emit(KnowledgeBaseLoaded(resources: resources)),
    );
  }

  Future<void> uploadFile(File file) async {
    emit(KnowledgeBaseLoading());
    await repository.uploadFile(file);
    getResources();
  }

  Future<void> uploadLink({required String link, String? title}) async {
    emit(KnowledgeBaseLoading());
    await repository.uploadLink(link: link, title: title);
    getResources();
  }
}
