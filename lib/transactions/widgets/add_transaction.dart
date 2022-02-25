import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twos_appwrite_trial/transactions/model/transaction.dart';
import 'package:twos_appwrite_trial/transactions/notifier/auth_state.dart';
import 'package:twos_appwrite_trial/transactions/notifiers/transaction_state.dart';

class AddTransaction extends StatefulWidget {
  final Transaction transaction;

  const AddTransaction({Key key, this.transaction}) : super(key: key);
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime today;
  DateTime _tdate;
  TextEditingController _titleController;
  TextEditingController _amountController;
  TextEditingController _descriptionController;
  bool _isEdit;
  int _transactionType;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.transaction != null;
    _transactionType = _isEdit ? widget.transaction.transactionType : 1;
    today = DateTime.now();
    _tdate = _isEdit ? widget.transaction.transactionDate : today;
    _titleController =
        TextEditingController(text: _isEdit ? widget.transaction.title : null);
    _amountController = TextEditingController(
        text: _isEdit ? widget.transaction.amount.toString() : null);
    _descriptionController = TextEditingController(
        text: _isEdit ? widget.transaction.description : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  groupValue: _transactionType,
                  value: 2,
                  title: const Text("Expense"),
                  onChanged: (val) {
                    setState(() {
                      _transactionType = val;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  groupValue: _transactionType,
                  value: 1,
                  title: const Text("Income"),
                  onChanged: (val) {
                    setState(() {
                      _transactionType = val;
                    });
                  },
                ),
              ),
            ],
          ),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(hintText: "title"),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(hintText: "amount"),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: "description"),
          ),
          const SizedBox(height: 10.0),
          CalendarDatePicker(
            firstDate: DateTime(today.year - 5),
            lastDate: DateTime(today.year + 5),
            initialDate: _tdate,
            onDateChanged: (date) {
              setState(() {
                _tdate = date;
              });
            },
          ),
          Center(
            child: ElevatedButton(
              child: const Text("Save"),
              onPressed: () async {
                String userId =
                    Provider.of<AuthState>(context, listen: false).user.id;
                try {
                  Transaction transaction = Transaction(
                    id: _isEdit ? widget.transaction.id : null,
                    title: _titleController.text,
                    amount: int.parse(_amountController.text),
                    description: _descriptionController.text,
                    transactionDate: _tdate,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    userId: userId,
                    transactionType: _transactionType,
                  );
                  TransactionState ts =
                      Provider.of<TransactionState>(context, listen: false);
                  if (_isEdit) {
                    await ts.updateTransaction(transaction);
                  } else {
                    await ts.addTransaction(transaction);
                  }
                  Navigator.pop(context);
                } catch (e) {
                  e.toString();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
