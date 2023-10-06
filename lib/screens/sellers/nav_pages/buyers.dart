import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/models/user_model.dart';

import '../../../constants/constants.dart';

class SellerUsersScreen extends StatefulWidget {
  const SellerUsersScreen({super.key});

  @override
  State<SellerUsersScreen> createState() => _SellerUsersScreenState();
}

class _SellerUsersScreenState extends State<SellerUsersScreen> {
  final userStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 4),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              // textAlign: TextAlign.center,
              "Active Users",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: userStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error occured while fetching data");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  final List<UserModel> gottenUsers =
                      (snapshot.data!.docs as List<QueryDocumentSnapshot>)
                          .map((e) => UserModel.fromFirestore(e))
                          .toList();

                  print(gottenUsers.length);

                  theUsers = gottenUsers;

                  return gottenUsers.isEmpty
                      ? const Center(child: Text("No active user "))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: gottenUsers.length,
                          itemBuilder: (context, index) {
                            var user = gottenUsers[index];
                            // var theDate = order.dateOfOrder;
                            // final date = DateFormat.yMMMMd().format(theDate);
                            return ListTile(
                                onTap: () {
                                  print(gottenUsers.length);
                                },
                                leading: CircleAvatar(
                                  child: Image.network(user.imageUrl!),
                                ),
                                title: Text('${user.displayName}'),
                                subtitle: Text(user.email!),
                                trailing: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete)));
                          });
                }
              })
        ],
      ),
    );
  }
}
