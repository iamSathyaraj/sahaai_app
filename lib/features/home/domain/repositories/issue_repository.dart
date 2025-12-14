import 'package:dio/dio.dart';
import '../entities/issue_entity.dart';
import 'dart:io';

abstract class IssueRepository {
  Future<IssueEntity> createIssue({
    required String title,
    required String description,
    required String locationId,
        required int serviceId, 
    List<File>? images,
    String? voicePath,
  });
}
