import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twos_appwrite_trial/transactions/notifier/auth_state.dart';
import 'package:twos_appwrite_trial/transactions/notifiers/transaction_state.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => AuthState(),
    lazy: false,
  ),
  ChangeNotifierProvider(
    create: (context) => TransactionState(),
  ),
];
