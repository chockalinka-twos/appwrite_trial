import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twos_appwrite_trial/pages/home.dart';
import 'package:twos_appwrite_trial/pages/login.dart';
import 'package:twos_appwrite_trial/transactions/notifier/auth_state.dart';
import 'package:twos_appwrite_trial/transactions/notifier/providers.dart';
import 'package:twos_appwrite_trial/transactions/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonColor: Colors.red,
            inputDecorationTheme:
                InputDecorationTheme(border: OutlineInputBorder()),
            buttonTheme: ButtonThemeData(
              height: 50.0,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            )),
        home: Consumer<AuthState>(
          builder: (context, state, child) {
            return state.isLoggedIn ? TransactionList() : LoginPage();
          },
        ),
      ),
    );
  }
}
