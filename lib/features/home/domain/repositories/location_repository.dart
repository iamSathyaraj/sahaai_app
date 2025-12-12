import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity?> saveLocation({
    required double latitude,
    required double longitude,
    required String address,
  });
  
  Future<List<LocationEntity>> getUserLocations();
  Future<LocationEntity> setPrimaryLocation(String locationId);
  Future<LocationEntity?> getPrimaryLocation();
}
