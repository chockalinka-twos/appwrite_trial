import 'package:flutter/material.dart';
import 'package:twos_appwrite_trial/transactions/model/transaction.dart';
import 'package:twos_appwrite_trial/transactions/widgets/add_transaction.dart';
import 'package:twos_appwrite_trial/transactions/widgets/transaction_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgeter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          )
        ],
      ),
      body: TransactionList(),
    );
  }
}
