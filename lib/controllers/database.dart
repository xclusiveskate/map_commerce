// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_commerce/models/cart_model.dart';
import 'package:map_commerce/models/order.dart';
import 'package:map_commerce/models/product.dart';

import 'package:map_commerce/models/user_model.dart';
import 'package:uuid/uuid.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final user = FirebaseAuth.instance.currentUser!.uid;
  static uploadProduct(
      {required String name,
      required String descripiton,
      required int amount,
      required int availableQuantity,
      required String category,
      required String productImageUrl}) async {
    try {
      final uid = const Uuid().v1();
      Product product = Product(
          id: uid,
          name: name,
          description: descripiton,
          amount: amount,
          availableQuantity: availableQuantity,
          imageUrl: productImageUrl,
          category: category);

      var prod =
          await _db.collection('products').doc(uid).set(product.toFirestore());
      return prod;
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  static saveUserData(UserCredential res) async {
    if (res.additionalUserInfo!.isNewUser) {
      final id = res.user!.uid;
      UserModel user = UserModel(
          userId: id,
          displayName: res.user!.displayName,
          email: res.user!.email,
          imageUrl: res.user!.photoURL);

      await _db.collection('users').doc(id).set(user.toJson());
      return id;
    }
  }

  static createOrder(
      {required List<CartItem> items,
      required int phoneNumber,
      required String address,
      required String nearbyAddress,
      // required int quantity,
      required transId,
      required double total}) async {
    try {
      final uuid = const Uuid().v1();
      OrderModel order = OrderModel(
          id: uuid,
          items: items,
          userId: user,
          dateOfOrder: DateTime.now(),
          deliveryAddress: address,
          nearbyDeliveryAddress: nearbyAddress,
          contactInfo: phoneNumber,
          // quantity: quantity,
          paymentId: transId,
          totalAmount: total,
          dateDelivered: null,
          isDelivered: false);

      var theOrder =
          await _db.collection('orders').doc(uuid).set(order.toFirestore());
      // await _db
      //     .collection('products')
      //     .doc(product.id)
      //     .update({'availableQuantity': product.availableQuantity - quantity});
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
