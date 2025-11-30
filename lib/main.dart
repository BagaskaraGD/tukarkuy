// lib/main.dart

import 'package:flutter/material.dart';
import 'package:tukarkuy/screens/home/home_screen.dart';
import 'package:tukarkuy/screens/splash_screen/splash_screen.dart';
import 'package:tukarkuy/utils/token_storage.dart';

import './theme.dart';
import './routes.dart';

void main() async {
  // <-- JADIKAN ASYNC
  WidgetsFlutterBinding.ensureInitialized(); // <-- WAJIB ADA

  // --- LOGIKA PENGECEKAN TOKEN ---
  final TokenStorage tokenStorage = TokenStorage();
  final String? token = await tokenStorage.getToken();

  // Tentukan halaman awal berdasarkan token
  String initialRoute = (token != null)
      ? HomeScreen.routeName
      : SplashScreen.routeName;
  // Jika ada token, langsung ke Home. Jika tidak, mulai dari Splash.
  // --- AKHIR LOGIKA ---

  runApp(MyApp(initialRoute: initialRoute)); // <-- KIRIM INITIAL ROUTE
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  // Terima initialRoute dari main()
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tukarkuy', // Ganti judul jika perlu
      theme: theme(),
      // Gunakan initialRoute yang sudah ditentukan
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}
