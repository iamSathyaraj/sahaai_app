import 'package:flutter/material.dart';
import 'package:sahaai/features/home/domain/entities/service_entity.dart';
import 'package:sahaai/features/home/domain/usecases/get_service_usecase.dart';

class HomeProvider extends  ChangeNotifier{

  List<ServiceEntity> services=[];
  bool isLoading=false;
  String? error;

  final GetServiceUsecase getServiceUsecase;

  HomeProvider(this.getServiceUsecase);

  Future<void>getHomeServices()async{
    isLoading=true;
    notifyListeners();
    
    try{
      services = await getServiceUsecase.call();
      error =null;
    } catch (e) {
      error = e.toString();
    } 

    isLoading=false;
    notifyListeners();
  }
}