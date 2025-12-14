// // features/home/data/repositories/location_repository_impl.dart
// import 'package:sahaai/features/home/data/sources/location_local_datasource.dart';

// import '../sources/location_remote_datasource.dart';  // Your DataSource
// import '../models/location_model.dart';
// import '../../domain/entities/location_entity.dart';
// import '../../domain/repositories/location_repository.dart';

// class LocationRepositoryImpl implements LocationRepository {
//   final LocationRemoteDataSource remoteDataSource; 
//     final LocationLocalDataSource localDataSource;   // ✅ YOUR DataSource

//   LocationRepositoryImpl(this.remoteDataSource,
//   this.localDataSource
//   );

//   @override
//   Future<LocationEntity?> saveLocation({
//     required double latitude,
//     required double longitude,
//     required String address,
//   }) async {
//     try {
//       final tempModel = LocationModel(
//         id: '',
//         latitude: latitude,
//         longitude: longitude,
//         address: address,
//         isPrimary: true,
//         timestamp: DateTime.now(),
//       );
      
//       final savedLocation = await remoteDataSource.saveLocation(tempModel);
//       return savedLocation;  
//     } catch (e) {
//       print('Repository saveLocation error: $e');
//       return null;
//     }
//   }

 
//   @override
//   Future<List<LocationEntity>> getUserLocations() async {
//     try {
//       return await remoteDataSource.getUserLocations();
//     } catch (e) {
//       print('Repository getUserLocations error: $e');
//       return [];  // ✅ Empty list on error
//     }
//   }

//   @override
//   Future<LocationEntity> setPrimaryLocation(String locationId) async {
//     try {
//       final location = await remoteDataSource.setPrimaryLocation(locationId);
//       await localDataSource.savePrimaryLocation(location.id, location.address);
//       return location;
//     } catch (e) {
//       print('Repository setPrimaryLocation error: $e');
//       rethrow;
//     }
//   }

//   @override
//   Future<LocationEntity?> getPrimaryLocation() async {
//     try {
//       final locations = await getUserLocations();
//       return locations.firstWhere(
//         (location) => location.isPrimary,
//         orElse: () => null,
//         // throw Exception('No primary location'),

//       );
//     } catch (e) {
//          print('No primary location found: $e');
//       return null;
//     }
//   }
// }
// features/home/data/repositories/location_repository_impl.dart
import '../sources/location_remote_datasource.dart';
import '../sources/location_local_datasource.dart';  // ✅ ADD THIS!
import '../models/location_model.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;  

  LocationRepositoryImpl(
    this.remoteDataSource, 
    this.localDataSource,  
  );

  @override
  Future<LocationEntity?> saveLocation({
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    try {
      final tempModel = LocationModel(
        id: '',
        latitude: latitude,
        longitude: longitude,
        address: address,
        isPrimary: true,  
        timestamp: DateTime.now(),
      );
      
      final savedLocation = await remoteDataSource.saveLocation(tempModel);
      
      if (savedLocation != null) {
        await localDataSource.savePrimaryLocation(savedLocation.id, savedLocation.address);
      }
      
      return savedLocation;
    } catch (e) {
      print('Repository saveLocation error: $e');
      return null;
    }
  }

  @override
  Future<List<LocationEntity>> getUserLocations() async {
    try {
      return await remoteDataSource.getUserLocations();
    } catch (e) {
      print('Repository getUserLocations error: $e');
      return [];  
    }
  }

  @override
  Future<LocationEntity> setPrimaryLocation(String locationId) async {
    try {
      final location = await remoteDataSource.setPrimaryLocation(locationId);
      await localDataSource.savePrimaryLocation(location.id, location.address);
      return location;
    } catch (e) {
      print('Repository setPrimaryLocation error: $e');
      rethrow;
    }
  }

  @override
  Future<LocationEntity?> getPrimaryLocation() async {
    try {
      final cachedId = await localDataSource.getPrimaryLocationAddress();
      if (cachedId != null) {
        return LocationModel(
          id: cachedId,
          latitude: 0, 
          longitude: 0,
          address: await localDataSource.getPrimaryLocationAddress() ?? 'Cached location',
          isPrimary: true,
          timestamp: DateTime.now(),
        );
      }
      
      final locations = await getUserLocations();
      return locations.firstWhere(
        (location) => location.isPrimary,
        orElse: () => throw Exception('No primary location'),
      );
    } catch (e) {
      print('No primary location found: $e');
      return null;
    }
  }
}

 