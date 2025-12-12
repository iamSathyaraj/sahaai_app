// // features/issue/data/datasources/issue_remote_datasource.dart
// import 'package:dio/dio.dart';
// import 'package:sahaai/core/network/dio_client.dart';
// import 'package:sahaai/features/home/domain/entities/issue_entity.dart';
// import '../models/issue_model.dart';

// abstract class IssueRemoteDataSource {
//   Future<IssueModel> createIssueWithMedia(FormData formData);
// }

// class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
//   final DioClient dioClient;

//   IssueRemoteDataSourceImpl(this.dioClient);

//   @override
//   Future<IssueModel> createIssueWithMedia(FormData formData) async {
//     try {
//       final response = await dioClient.dio.post(
//         '/issues',
//         data: formData,
//         options: Options(contentType: 'multipart/form-data'),
//       );
//       return IssueModel.fromJson(response.data['data']);
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// features/issue/data/datasources/issue_remote_datasource.dart

import 'package:sahaai/features/home/domain/entities/issue_entity.dart';

abstract class IssueRemoteDataSource {
  Future<IssueEntity> createIssue({
    required String title,
    required String description,
    required String locationId,
    required int serviceId,
    List<dynamic>? images,
    String? voicePath,
  });
}
