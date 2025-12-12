class IssueEntity {
  final String id;
  final String title;  
  final String description;
  final String locationId;
  final String serviceType;
  final List<String> imageUrls;
  final String? voiceUrl;
  final DateTime createdAt;

  const IssueEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.locationId,
    required this.serviceType,
    this.imageUrls = const [],
    this.voiceUrl,
    required this.createdAt,
  });
}
