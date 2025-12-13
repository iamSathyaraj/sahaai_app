
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sahaai/features/home/data/models/location_model.dart';
// import 'package:sahaai/features/home/data/sources/location_remote_datasource.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sahaai/core/services/location_service.dart';
// import 'package:sahaai/features/home/data/repositories/location_repository_impl.dart';
// import 'package:sahaai/features/home/domain/repositories/location_repository.dart';
// import 'package:sahaai/core/network/dio_client.dart';
// import 'package:sahaai/features/home/domain/entities/location_entity.dart';

// class LocationProvider with ChangeNotifier {
//   LocationEntity? _primaryLocation;
//   List<LocationEntity> _locations = [];
//   bool _isLoading = false;
//   String? _error;

//   LocationEntity? get primaryLocation => _primaryLocation;
//   List<LocationEntity> get locations => _locations;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   bool get hasPrimaryLocation => _primaryLocation != null;
//   String get displayAddress => _primaryLocation?.address ?? 'Set location';
//   String? get errorMessage => _error;
//   String? primaryLocationId;
//   String? primaryAddress;
//   late final LocationRepository _repository;
//   LocationProvider(this._repository); 


//    Future<void> loadCachedPrimary() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       primaryLocationId = prefs.getString('primary_location_id');
//       primaryAddress = prefs.getString('primary_location_address');
      
//       // Also try old cache format
//       if (primaryAddress == null) {
//         final cachedAddress = prefs.getString('primary_location');
//         if (cachedAddress != null) {
//           primaryAddress = cachedAddress;
//         }
//       }
      
//       notifyListeners();
//     } catch (e) {
//       print('Cache load error: $e');
//     }
//   }



//   Future<void> init() async {
//     await _loadCachedPrimary();
//   }



//   Future<bool> requestPermission() async {
//     final status = await Permission.location.status;
//     if (!status.isGranted) {
//       final result = await Permission.location.request();
//       return result.isGranted;
//     }
//     return true;
//   }
// Future<void> requestLocationPermissionAndFetchFirstTime() async {
//   _isLoading = true;
//   notifyListeners();

//   final hasPermission = await requestPermission();
//   if (!hasPermission) {
//     _error = 'Location permission denied';
//     _isLoading = false;
//     notifyListeners();
//     return;
//   }

//   try {
//     final locationData = await LocationService.getCurrentLocation();
//     if (locationData != null) {
//       final location = await _repository.saveLocation(
//         latitude: locationData['latitude'],
//         longitude: locationData['longitude'],
//         address: locationData['address'],
//       );
//       if (location != null) {
//         _primaryLocation = location;
//         _locations.insert(0, location);
//         await _cachePrimaryLocation(location);
//       }
//     }
//   } catch (e) {
//     _error = e.toString();
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }


//   Future<String?> fetchFirstLocation() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final hasPermission = await requestPermission();
//       if (!hasPermission) {
//         _error = 'Location permission denied';
//         return null;
//       }

//       final locationData = await LocationService.getCurrentLocation();
//       if (locationData == null) {
//         _error = 'Unable to get location';
//         return null;
//       }

//       final location = await _repository.saveLocation(
//         latitude: locationData['latitude'],
//         longitude: locationData['longitude'],
//         address: locationData['address'],
//       );

//       if (location != null) {
//         _primaryLocation = location;
//         primaryLocationId = location.id;
//         primaryAddress = location.address;
//         _locations.insert(0, location);
//         await _cachePrimaryLocation(location);
//       }

//       return location?.id;
//     } catch (e) {
//       _error = e.toString();
//       return null;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> fetchCurrentLocationAndSave() async {
//   _isLoading = true;
//   _error = null;
//   notifyListeners();

//   final hasPermission = await requestPermission();
//   if (!hasPermission) {
//     _error = 'Location permission denied';
//     _isLoading = false;
//     notifyListeners();
//     return;
//   }

//   try {
//     final locationData = await LocationService.getCurrentLocation();
//     if (locationData != null) {
//       final location = await _repository.saveLocation(
//         latitude: locationData['latitude'],
//         longitude: locationData['longitude'],
//         address: locationData['address'],
//       );
//       if (location != null) { 
//         _locations.insert(0, location);
//         // optional: if you want latest as primary in some flows
//         // _primaryLocation = location;
//       }
//     }
//   } catch (e) {
//     _error = e.toString();
//   } finally {
//     _isLoading = false;
//     notifyListeners();
//   }
// }
 

//    Future<void> _loadCachedPrimary() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final cachedAddress = prefs.getString('primary_location');
//       if (cachedAddress != null && _primaryLocation == null) {
//         _primaryLocation = LocationModel(
//           id: 'cached',
//           latitude: 0,
//           longitude: 0,
//           address: cachedAddress,
//           isPrimary: true,
//           timestamp: DateTime.now(),
//         );
//         notifyListeners();
//       }
//     } catch (e) {}
//   }


//    Future<void> _cachePrimaryLocation(LocationEntity location) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('primary_location', location.address);
//     } catch (e) {}
//   }

//   void clearError() {
//     _error = null;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sahaai/features/home/data/models/location_model.dart';
import 'package:sahaai/features/home/data/sources/location_remote_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sahaai/core/services/location_service.dart';
import 'package:sahaai/features/home/data/repositories/location_repository_impl.dart';
import 'package:sahaai/features/home/domain/repositories/location_repository.dart';
import 'package:sahaai/core/network/dio_client.dart';
import 'package:sahaai/features/home/domain/entities/location_entity.dart';

class LocationProvider with ChangeNotifier {
  LocationEntity? _primaryLocation;
  List<LocationEntity> _locations = [];
  bool _isLoading = false;
  String? _error;

  String? primaryLocationId;
  String? primaryAddress;

  LocationEntity? get primaryLocation => _primaryLocation;
  List<LocationEntity> get locations => _locations;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasPrimaryLocation => _primaryLocation != null || primaryLocationId != null;
  String get displayAddress => primaryAddress ?? _primaryLocation?.address ?? 'Set location';
  String? get errorMessage => _error;

  late final LocationRepository _repository;
  LocationProvider(this._repository);

  Future<void> loadCachedPrimary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      primaryLocationId = prefs.getString('primary_location_id');
      primaryAddress = prefs.getString('primary_location_address');
      
      if (primaryAddress == null) {
        final cachedAddress = prefs.getString('primary_location');
        if (cachedAddress != null) {
          primaryAddress = cachedAddress;
        }
      }
      
      notifyListeners();
    } catch (e) {
      print('Cache load error: $e');
    }
  }

Future<String?> fetchFirstLocation() async {
  
  _isLoading = true;
  _error = null;
  notifyListeners();

  try {
    final status = await Permission.location.status;
    
    final hasPermission = await requestPermission();
    
    if (!hasPermission) {
      _error = 'Location permission denied';
      return null;
    }

    final locationData = await LocationService.getCurrentLocation();
    
    if (locationData == null) {
      _error = 'Unable to get location';
      return null;
    }

  
    
    final location = await _repository.saveLocation(
      latitude: locationData['latitude'],
      longitude: locationData['longitude'],
      address: locationData['address'],
    );


    if (location != null) {
      _primaryLocation = location;
      primaryLocationId = location.id;
      primaryAddress = location.address;
      _locations.insert(0, location);
      await _cachePrimaryLocation(location);
    } else {
    }

    return location?.id;
  } catch (e) {
    _error = e.toString();
    return null;
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  // Future<String?> fetchFirstLocation() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final hasPermission = await requestPermission();
  //     if (!hasPermission) {
  //       _error = 'Location permission denied';
  //       return null;
  //     }

  //     final locationData = await LocationService.getCurrentLocation();
  //     if (locationData == null) {
  //       _error = 'Unable to get location';
  //       return null;
  //     }

  //     final location = await _repository.saveLocation(
  //       latitude: locationData['latitude'],
  //       longitude: locationData['longitude'],
  //       address: locationData['address'],
  //     );

  //     if (location != null) {
  //       _primaryLocation = location;
  //       primaryLocationId = location.id;
  //       primaryAddress = location.address;
  //       _locations.insert(0, location);
  //       await _cachePrimaryLocation(location);
  //     }

  //     return location?.id;
  //   } catch (e) {
  //     _error = e.toString();
  //     return null;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> loadLocationHistory() async {
    _isLoading = true;
    notifyListeners();
    try {
      _locations = await _repository.getUserLocations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> requestPermission() async {
    final status = await Permission.location.status;
    if (!status.isGranted) {
      final result = await Permission.location.request();
      return result.isGranted;
    }
    return true;
  }

  Future<void> fetchCurrentLocationAndSave() async {
    await fetchFirstLocation();  
  }

  Future<void> _cachePrimaryLocation(LocationEntity location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('primary_location_id', location.id);
      await prefs.setString('primary_location_address', location.address);
      await prefs.setString('primary_location', location.address);  
    } catch (e) {
      print('Cache save error: $e');
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
