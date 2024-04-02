import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final int amount;
  final int availableQuantity;
  final String imageUrl;
  final String category;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.availableQuantity,
    required this.imageUrl,
    required this.category,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'amount': amount,
      'availableQuantity': availableQuantity,
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  factory Product.fromFirestore(DocumentSnapshot documents) {
    final data = documents.data() as Map;
    return Product(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      amount: data['amount'] as int,
      availableQuantity: data['availableQuantity'] as int,
      imageUrl: data['imageUrl'] as String,
      category: data['category'] as String,
    );
  }
}
