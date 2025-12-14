// features/issue/data/models/issue_model.dart
import 'dart:convert';

import '../../domain/entities/issue_entity.dart';

class IssueModel extends IssueEntity {
  const IssueModel({
    required super.id,
    required super.title,
    required super.description,
    required super.locationId,
    required super.serviceType,
    super.imageUrls,
    super.voiceUrl,
    required super.createdAt,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    return IssueModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      locationId: json['addressId']?.toString() ?? '',
  serviceType: _idToServiceType(json['serviceId']?.toString() ?? '1'),
      //  json['serviceType'] ?? '',
      imageUrls: json['imageUrls'] == null
        ? []
        : (json['imageUrls'] is List
            ? List<String>.from(json['imageUrls'])
            : List<String>.from(jsonDecode(json['imageUrls']))), 
      voiceUrl: json['voiceUrl'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
   }
static String _idToServiceType(String serviceId) {
  return switch(serviceId) {
    '1' => 'electrician',
    '2' => 'plumber',
    '3' => 'carpenter',
    _ => 'electrician',
  };
}

  }
