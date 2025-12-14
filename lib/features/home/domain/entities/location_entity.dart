class LocationEntity {
  final String id;
  final double latitude;
  final double longitude;
  final String address;
  final bool isPrimary;
  final DateTime timestamp;
  final String? city;     
  final String? state;
  final String? pincode;

  const LocationEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.isPrimary,
    required this.timestamp,
    this.city,
    this.state,
    this.pincode,
  });
}
