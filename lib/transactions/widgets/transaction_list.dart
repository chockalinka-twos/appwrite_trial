import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twos_appwrite_trial/transactions/model/transaction.dart';
import 'package:twos_appwrite_trial/transactions/notifiers/transaction_state.dart';
import 'package:twos_appwrite_trial/transactions/widgets/add_transaction.dart';
import 'package:twos_appwrite_trial/transactions/widgets/transaction_details.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions =
        Provider.of<TransactionState>(context).transactions;

    return Scaffold(
      appBar: AppBar(title: const Text('transactions'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
      ]),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          Transaction transaction = transactions[index];
          return ListTile(
            leading: Icon(transaction.transactionType == 1
                ? Icons.account_balance_wallet
                : Icons.view_list),
            title: Text(transaction.title),
            subtitle:
                Text(DateFormat.yMMMEd().format(transaction.transactionDate)),
            trailing: Text(transaction.amount.toString()),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TransactionDetails(
                      transaction: transaction,
                    ),
                  ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => AddTransaction()));
          }),
    );
  }
}
