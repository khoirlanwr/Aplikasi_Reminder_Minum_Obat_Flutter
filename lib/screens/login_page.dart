import 'package:flutter/material.dart';
import 'package:reminder_app/blocs/user_authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  loginAccount(String email, String password) {
    userAuthentication.loginAccount(
        _emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    var loginBanner = Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
      child: Text(
        'LOGIN PAGE',
        style: TextStyle(
            fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );

    var emailField = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 75),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(hintText: 'Email.'),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
    );

    var passwordField = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 75),
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(hintText: 'Password.'),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
    );

    var loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 75),
      child: GestureDetector(
        onTap: () {
          loginAccount(_emailController.text, _passwordController.text);
        },
        child: Container(
          width: double.infinity,
          height: 60.0,
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [loginBanner, emailField, passwordField, loginButton],
        ),
      ),
    );
  }
}
