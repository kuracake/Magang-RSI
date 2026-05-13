import 'package:flutter/material.dart';
import 'package:magang_yusuf/halaman/halaman_home_scan.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:magang_yusuf/halaman/halaman_login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HalamanHomeScan()
    );
  }
}
