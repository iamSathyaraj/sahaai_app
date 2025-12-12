
// import 'package:dio/dio.dart';
// import 'package:sahaai/features/home/data/sources/issue_remote_data_source.dart';
// import '../../domain/entities/issue_entity.dart';
// import '../../domain/repositories/issue_repository.dart';
// import 'dart:io';

// class IssueRepositoryImpl implements IssueRepository {
//   final IssueRemoteDataSource remoteDataSource;

//   IssueRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<IssueEntity> createIssue({
//     required String title,
//     required String description,
//     required String locationId,
//     // required String serviceType,
//       required int serviceId,     

//     List<File>? images,
//     String? voicePath,
//   }) async {
//     final formData = FormData.fromMap({
//         'serviceId': serviceId,  

//       'title': title,
//       'description': description,
//       'addressId': locationId,
//       // 'serviceType': serviceType,
//     });

//     // Add images
//     if (images != null && images.isNotEmpty) {
//       for (int i = 0; i < images.length; i++) {
//         formData.files.add(MapEntry(
//           'ImageFiles',
//           await MultipartFile.fromFile(
//             images[i].path,
//             filename: 'img_$i.jpg',
//           ),
//         ));
//       }
//     }

//     // Add voice
//     if (voicePath != null && voicePath.isNotEmpty && File(voicePath).existsSync()) {
//       formData.files.add(MapEntry(
//         'AudioFile',
//         await MultipartFile.fromFile(
//           voicePath,
//           filename: 'voice.m4a'
//         ),
//       ));
//     }

//     final issueModel = await remoteDataSource.createIssueWithMedia(formData);
//     return issueModel;
//   }
  

// }


// features/issue/data/repositories/issue_repository_impl.dart
import 'package:sahaai/features/home/data/sources/issue_remote_data_source.dart';
import '../../domain/entities/issue_entity.dart';
import '../../domain/repositories/issue_repository.dart';

class IssueRepositoryImpl implements IssueRepository {
  final IssueRemoteDataSource remoteDataSource;

  IssueRepositoryImpl(this.remoteDataSource);

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
      return await remoteDataSource.createIssue(
        title: title,
        description: description,
        locationId: locationId,
        serviceId: serviceId,
        images: images,
        voicePath: voicePath,
      );
    } catch (e) {
      throw Exception('Failed to create issue: $e');
    }
  }
}
