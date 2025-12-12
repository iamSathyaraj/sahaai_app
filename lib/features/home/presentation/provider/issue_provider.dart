
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sahaai/core/network/dio_client.dart';
import 'package:sahaai/features/home/data/repositories/issue_repository_impl.dart';
import 'package:sahaai/features/home/data/sources/issue_remote_data_source.dart';
import 'package:sahaai/features/home/domain/usecases/create_issue_usecase.dart';
import '../../domain/repositories/issue_repository.dart';

class IssueProvider with ChangeNotifier {
  // final IssueRepository _repository;
    final CreateIssueUseCase createIssueUseCase;

  bool _isSubmitting = false;
  String? _error;
  String? _successMessage;
  IssueProvider(this.createIssueUseCase);
  bool get isSubmitting => _isSubmitting;
  String? get error => _error;
  String? get successMessage => _successMessage;

  Future<bool> submitIssue({
    // required String title,
    required String description,
    required String locationId,
  required int serviceId,     
    List<File>? images,
    String? voicePath,
  }) async {
    _isSubmitting = true;
    _error = null;
    _successMessage = null;
    notifyListeners();


  try {
      final title = ' Service Issue';
      await createIssueUseCase.execute(
        title: title,
        description: description,
        locationId: locationId,
            serviceId: serviceId,     

        // serviceType: serviceType,
        images: images,
        voicePath: voicePath,
      );

      _successMessage = 'Issue created successfully!';
      return true;
    } catch (e) {
      _error = 'Failed to create issue: $e';
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }
}
