
import 'package:sahaai/core/network/dio_client.dart';
import '../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<LocationModel> saveLocation(LocationModel location);
  Future<List<LocationModel>> getUserLocations();
  Future<LocationModel> setPrimaryLocation(String locationId);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final DioClient dioClient;

  LocationRemoteDataSourceImpl(this.dioClient);

  @override
  Future<LocationModel> saveLocation(LocationModel location) async {
    try {
      final response = await dioClient.dio.post(
         '/userlocation',
        data: location.toJson(),
      );
      return LocationModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LocationModel>> getUserLocations() async {
    try {
      final response = await dioClient.dio.get( '/userlocation');
      return (response.data['data'] as List)
          .map((json) => LocationModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<LocationModel> setPrimaryLocation(String locationId) async {
    try {
      final response = await dioClient.dio.patch('/user/locations/$locationId/primary');
      return LocationModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
