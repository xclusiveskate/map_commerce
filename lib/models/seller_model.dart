import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  final String userId;
  final String displayName;
  final String photoUrl;
  final String storeName;
  final String storeDescription;
  final String email;
  final String password;
  Seller({
    required this.userId,
    required this.displayName,
    required this.photoUrl,
    required this.storeName,
    required this.storeDescription,
    required this.email,
    required this.password,
  });

  Seller copyWith({
    String? userId,
    String? displayName,
    String? photoUrl,
    String? storeName,
    String? storeDescription,
    String? email,
    String? password,
  }) {
    return Seller(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      storeName: storeName ?? this.storeName,
      storeDescription: storeDescription ?? this.storeDescription,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'storeName': storeName,
      'storeDescription': storeDescription,
      'email': email,
      'password': password,
    };
  }

  factory Seller.fromFirestore(DocumentSnapshot document) {
    final data = document.data() as Map;
    return Seller(
      userId: data['userId'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      storeName: data['storeName'] ?? '',
      storeDescription: data['storeDescription'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
    );
  }
}
