// features/issue/domain/usecases/create_issue_usecase.dart
import '../entities/issue_entity.dart';
import '../repositories/issue_repository.dart';
import 'dart:io';

class CreateIssueUseCase {
  final IssueRepository repository;

  CreateIssueUseCase(this.repository);

  Future<IssueEntity> execute({
    required String title,
    required String description,
    required String locationId,
    required int serviceId,
    List<File>? images,
    String? voicePath,
  }) async {
    return await repository.createIssue(
      title: title,
      description: description,
      locationId: locationId,
      serviceId: serviceId,
      images: images,
      voicePath: voicePath,
    );
  }
}
