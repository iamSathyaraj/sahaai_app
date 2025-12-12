import 'package:sahaai/core/network/api_service.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeService homeService;

  HomeRepositoryImpl(this.homeService);

  @override
  Future<List<ServiceEntity>> getService() async {
    try {
      final serviceModels = await homeService.getServices();
      return serviceModels.map((model)=>model.toEntity()).toList();
    } catch (e) {
      throw Exception('Services fetch failed: $e');
    }
  }
}


