import 'package:image_picker/image_picker.dart';

pickImage({required String image}) async {
  ImagePicker pick = ImagePicker();
  XFile? file = await pick.pickImage(source: ImageSource.gallery);
  if (file != null) {
    image = file.path;
    // setState(() {});
  }
}
