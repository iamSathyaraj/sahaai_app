import '../../domain/entities/worker_entity.dart';

class WorkerModel extends WorkerEntity {
  WorkerModel({
    required super.id,
    required super.name,
    required super.rating,
    required super.distanceKm,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['workerId'].toString(),
      name: json['name'] as String,
      rating: (json['rating'] as num).toDouble(),
      distanceKm: (json['distanceKm'] as num).toDouble(),
    );
  }
}
