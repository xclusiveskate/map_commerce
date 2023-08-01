import 'package:flutter/material.dart';

import 'package:map_commerce/controllers/auth.dart';
import 'package:map_commerce/screens/auth/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../local_storage/check_admin.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passControl = TextEditingController();

  signIn() async {
    await Authentication.signInAdminWithEmail(
        context: context, email: emailControl.text, password: passControl.text);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 35),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Welcome!! ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  isAdmin!
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text("Sign up"))
                      : const SizedBox()
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Sign up to explore beautiful items in our store",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              isAdmin!
                  ? SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: emailControl,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.all(2),
                                  border: OutlineInputBorder(),
                                  labelText: "email"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: passControl,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.password),
                                  contentPadding: EdgeInsets.all(2),
                                  border: OutlineInputBorder(),
                                  labelText: "password"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                signIn();
                              },
                              child: const Text("Log in"))
                        ],
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () async {
                        Authentication.signUserUpWithGoogle();
                      },
                      child: const Text("Sign up with your google account")),
              const SizedBox(
                height: 50,
              ),
              Divider(
                endIndent: 1.0,
                indent: 1.0,
                color: Colors.grey.withOpacity(1),
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Log in as"),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          isAdmin = !isAdmin!;
                        });

                        final pref = await SharedPreferences.getInstance();
                        await pref.setBool('isAdmin', isAdmin!);
                      },
                      child:
                          isAdmin! ? const Text("user") : const Text("admin"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
