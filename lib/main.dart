import 'package:flutter/material.dart';
import 'package:tcg_op/src/controllers/card_data_controller.dart';
import 'package:tcg_op/src/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> CardDataController()),
      ],
      child: MaterialApp(
          title: 'TCG One Piece',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch:  Colors.orange,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.black,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          home: const HomePage(),
        ),
        );
  }
}
