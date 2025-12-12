import 'package:sahaai/features/home/domain/entities/service_entity.dart';
import 'package:sahaai/features/home/domain/repositories/home_repository.dart';

class GetServiceUsecase {
    final HomeRepository homeRepository;

    GetServiceUsecase(this.homeRepository);
Future<List<ServiceEntity>> call(){
  return homeRepository.getService();
}

}