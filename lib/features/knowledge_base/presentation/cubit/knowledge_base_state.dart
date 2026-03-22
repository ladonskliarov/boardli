part of 'knowledge_base_cubit.dart';

sealed class KnowledgeBaseState extends Equatable {
  const KnowledgeBaseState();

  @override
  List<Object> get props => [];
}

final class KnowledgeBaseInitial extends KnowledgeBaseState {}

final class KnowledgeBaseLoading extends KnowledgeBaseState {}

final class KnowledgeBaseLoaded extends KnowledgeBaseState {
  final List<Resource> resources;

  const KnowledgeBaseLoaded({required this.resources});

  @override
  List<Object> get props => [resources];
}

final class KnowledgeBaseFailure extends KnowledgeBaseState {
  final String message;

  const KnowledgeBaseFailure({required this.message});

  @override
  List<Object> get props => [message];
} 