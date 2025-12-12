import '../../domain/entities/service_entity.dart';

class ServiceModel {
  final int id;
  final String name;
  final String imageUrl;

  ServiceModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int,
      name: json['serviceName'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  ServiceEntity toEntity() => ServiceEntity(
        id: id,
        name: name,
        imageUrl: imageUrl,
      );
}
