abstract class WorkerStatusRepository {
Future <void> setOnline();
Future <void> setOffline();
Future<bool> getCurrentStatus(); 

}