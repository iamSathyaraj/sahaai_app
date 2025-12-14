import 'package:sahaai/features/home/domain/entities/service_entity.dart';

abstract class HomeRepository {
  Future<List<ServiceEntity>> getService();
}