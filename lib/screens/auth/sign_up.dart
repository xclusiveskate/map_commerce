// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:map_commerce/constants/constants.dart';
import 'package:map_commerce/controllers/auth.dart';
import 'package:map_commerce/controllers/cloudinary.dart';
import 'package:map_commerce/utils/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String image = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController storeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  signUp({required BuildContext theContext}) async {
    String photoUrl = await CloudMethod().saveImageToCloudinary(img: image);
    final res = await Authentication.signAdminUpWithEmailAndPassword(
        context: theContext,
        displayName: nameController.text,
        storeName: storeController.text,
        email: emailController.text,
        password: passController.text,
        storeDescription: descriptionController.text,
        photoUrl: photoUrl);
    Navigator.pop(context);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      image.isEmpty
                          ? const SizedBox(
                              height: 200,
                              width: 200,
                              child: Card(
                                color: Colors.blue,
                              ))
                          : SizedBox(
                              height: 200,
                              width: 200,
                              child: Card(
                                // color: Colors.blue,
                                child: Image.file(File(image)),
                              ),
                            ),
                      TextButton(
                          onPressed: () {
                            pickImage(image: image);
                          },
                          child: const Text("Pick image"))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.verified_user),
                        hintText: "display name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: storeController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.store),
                        hintText: "store name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "email address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 5,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.shop),
                        hintText: "about store",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      signUp(theContext: context);
                    },
                    child: const Text("Sign up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
