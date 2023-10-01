import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_commerce/firebase_options.dart';
import 'package:map_commerce/provider/admin.change.dart';
import 'package:map_commerce/provider/sign_in_provider.dart';
import 'package:map_commerce/screens/auth/check_user.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AdminChanger>(create: (context) => AdminChanger()),
    ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
    // ChangeNotifierProvider<CartProvider>(create: (context) => CartProvider()),
    // ChangeNotifierProvider<ProductProvider>(
    //     create: (context) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error loading this page"),
              );
            } else {
              return CheckIfUserActive(
                user: snapshot.data,
              );
            }
          }),
    );
  }
}
