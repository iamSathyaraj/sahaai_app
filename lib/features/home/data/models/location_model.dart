
import 'package:sahaai/features/home/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.address,     
    required super.isPrimary,  
    required super.timestamp,
    String? city,
    String? state,
    String? pincode,
  }) : super(
          city: city,
          state: state,
          pincode: pincode,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'].toString(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      address: json['fullAddress'] ?? '',
      isPrimary: json['isDefault'] ?? false,
      timestamp: DateTime.now(),
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullAddress': address,
      'latitude': latitude,
      'longitude': longitude,
      'city': city ?? '',
      'state': state ?? '',
      'pincode': pincode ?? '',
      'isDefault': isPrimary,
    };
  }
}
