import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String? displayName;
  final String? email;
  final String? imageUrl;
  UserModel({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot document) {
    final data = document.data() as Map;
    return UserModel(
      userId: data['userId'] as String,
      displayName: data['displayName'] as String,
      email: data['email'] as String,
      imageUrl: data['imageUrl'] as String,
    );
  }
}
