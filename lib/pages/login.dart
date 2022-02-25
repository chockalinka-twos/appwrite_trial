import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:twos_appwrite_trial/data/service/api_service.dart';
import 'package:twos_appwrite_trial/res/app_constants.dart';
import 'package:twos_appwrite_trial/transactions/widgets/transaction_list.dart';
import './signup.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email;
  TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    fetchAlbum();
    super.initState();
  }

  fetchAlbum() async {
    var response = await http.get(
        Uri.parse('${AppConstant.endpoint}/${AppConstant.project}/health'));
    print(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: "email"),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "password",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                //login user
                try {
                  await ApiService.instance
                      .login(email: _email.text, password: _password.text);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => TransactionList()));
                } on AppwriteException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? "Unknown error")));
                }
              },
              child:const Text("Login"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SignupPage(),
                  ),
                );
              },
              child:const Text("Not registered? Sign up."),
            ),
          ],
        ),
      ),
    );
  }
}
