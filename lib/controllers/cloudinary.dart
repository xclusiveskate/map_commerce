import 'package:cloudinary_public/cloudinary_public.dart';

class CloudMethod {
  Future<String> saveImageToCloudinary({required String img}) async {
    final cloud = CloudinaryPublic('dsxaqfgrc', 'jxe7hcul');

    var cloudStorage = await cloud.uploadFile(CloudinaryFile.fromFile(img));
    return cloudStorage.url;
  }
}
