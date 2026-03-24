import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/datasource/knowledge_base_datasource.dart';
import '../../data/models/resource.dart';

class KnowledgeBaseRepository {
  final KnowledgeBaseDatasource datasource;
  const KnowledgeBaseRepository({required this.datasource});

  Future<Either<Failure, List<Resource>>> getResources() async {
    try {
      final resources = await datasource.getResources();
      final List<Resource> reversedResources = resources.reversed.toList();
      return Right(reversedResources);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch resources: $e'));
    }
  }

  Future<Either<Failure, void>> uploadLink({
    required String link,
    String? title,
  }) async {
    try {
      await datasource.uploadLink(link: link, title: title);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to upload link: $e'));
    }
  }

  Future<Either<Failure, void>> uploadFile(File file) async {
    try {
      await datasource.uploadFile(file);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to upload file: $e'));
    }
  }

  Future<Either<Failure, void>> deleteResource(String resourceId) async {
    try {
      await datasource.deleteResource(resourceId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete resource: $e'));
    }
  }
}
