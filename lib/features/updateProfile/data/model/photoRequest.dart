import 'dart:io';

class Photorequest {
  final File image;
  Photorequest({required this.image});
  Map<String, dynamic> toJson() {
    return {"image": image.path};
  }
}
