// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_commerce/controllers/cloudinary.dart';
import 'package:map_commerce/controllers/database.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameControl = TextEditingController();
  TextEditingController amountControl = TextEditingController();
  TextEditingController availableControl = TextEditingController();
  TextEditingController categoryControl = TextEditingController();

  String image = "";

  pickImage() async {
    ImagePicker pick = ImagePicker();
    XFile? file = await pick.pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = file.path;
      setState(() {});
    }
  }

  uploadProduct() async {
    final theImage = await CloudMethod().saveImageToCloudinary(img: image);

    final product = await Database.uploadProduct(
        name: nameControl.text,
        amount: int.parse(amountControl.text),
        availableQuantity: int.parse(availableControl.text),
        category: categoryControl.text,
        productImageUrl: theImage);
    print(product.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload New Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameControl,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(6),
                    border: OutlineInputBorder(),
                    labelText: "name of product"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountControl,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(6),
                    border: OutlineInputBorder(),
                    labelText: "price"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: availableControl,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(6),
                    border: OutlineInputBorder(),
                    labelText: "Available quantity"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: categoryControl,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(6),
                    border: OutlineInputBorder(),
                    labelText: "Category"),
              ),
              const SizedBox(
                height: 10,
              ),
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text("Pick Image")),
              ),
              const SizedBox(
                height: 40,
              ),
              OutlinedButton(
                  onPressed: () {
                    uploadProduct();
                    Navigator.pop(context);
                  },
                  child: const Text("Upload Product"))
            ],
          ),
        ),
      ),
    );
  }
}
