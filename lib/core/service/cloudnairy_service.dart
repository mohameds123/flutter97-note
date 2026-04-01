import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryService {
  final Dio dio = Dio();

  final String cloudName = 'dfntymllg';
  final String uploadPreset = 'noteImages';

  Future<String> uploadImage(File imageFile) async {
    final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    final formData = FormData.fromMap({
      'upload_preset': uploadPreset,
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    final response = await dio.post(
      url,
      data: formData,
    );

    return response.data['secure_url'];
  }
}