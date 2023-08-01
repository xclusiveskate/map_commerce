// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_commerce/models/order.dart';
import 'package:map_commerce/models/product.dart';

import 'package:map_commerce/models/user.dart';
import 'package:uuid/uuid.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final user = FirebaseAuth.instance.currentUser!.uid;
  static uploadProduct(
      {required String name,
      required int amount,
      required int availableQuantity,
      required String category,
      required String productImageUrl}) async {
    try {
      final uid = const Uuid().v1();
      Product product = Product(
          id: uid,
          name: name,
          amount: amount,
          availableQuantity: availableQuantity,
          imageUrl: productImageUrl,
          category: category);

      var prod =
          await _db.collection('products').doc(uid).set(product.toJson());
      return prod;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  static saveUserData(UserCredential res) async {
    if (res.additionalUserInfo!.isNewUser) {
      final id = res.user!.uid;
      UserModel user = UserModel(
          userId: res.user!.uid,
          displayName: res.user!.displayName,
          email: res.user!.email,
          imageUrl: res.user!.photoURL);

      await _db.collection('users').doc(id).set(user.toJson());
    }
  }

  static createOrder(
      {required String productId,
      required int phoneNumber,
      required String address,
      required int quantity,
      required int total}) async {
    try {
      final uuid = const Uuid().v1();
      OrderModel order = OrderModel(
          // id: uid,
          id: uuid,
          productId: productId,
          userId: user,
          dateOfOrder: DateTime.now(),
          deliveryAddress: address,
          contactInfo: phoneNumber,
          quantity: quantity,
          totalAmount: total,
          dateDelivered: null,
          isDelivered: false);

      var theOrder =
          await _db.collection('orders').doc(uuid).set(order.toJson());
      return theOrder;
    } catch (e) {
      print(e.toString());
    }
  }

  // static saveAdminData(Seller sellerDetails) {
  //   Seller seller = Seller(
  //       userId: uid,
  //       displayName: sellerDetails.displayName,
  //       photoUrl: sellerDetails.photoUrl,
  //       storeName: sellerDetails.storeName,
  //       storeDescription: sellerDetails.storeDescription,
  //       email: sellerDetails.email,
  //       password: sellerDetails.password);

  //   _db.collection('seller').doc(uid).set(seller.toJson());
  // }
}