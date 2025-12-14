// features/issue/data/datasources/issue_remote_datasource_impl.dart
import 'package:dio/dio.dart';
import 'package:sahaai/core/network/dio_client.dart';
import 'package:sahaai/features/home/data/sources/issue_remote_data_source.dart';
import '../../domain/entities/issue_entity.dart';
import '../models/issue_model.dart';

class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
  final DioClient dioClient;

  IssueRemoteDataSourceImpl(this.dioClient);

  @override
  Future<IssueEntity> createIssue({
    required String title,
    required String description,
    required String locationId,
    required int serviceId,
    List<dynamic>? images,
    String? voicePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'addressId': locationId,
        'serviceId': serviceId.toString(),
      });

      if (images != null && images.isNotEmpty) {
        for (var image in images) {
          formData.files.add(MapEntry(
            'ImageFiles',
            await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
          ));
        }
      }

      if (voicePath != null) {
        formData.files.add(MapEntry(
          'AudioFile',
          await MultipartFile.fromFile(voicePath, filename: voicePath.split('/').last),
        ));
      }

      final response = await dioClient.dio.post('/issues', data: formData);
      return IssueModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
