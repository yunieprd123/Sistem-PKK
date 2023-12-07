import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:kebaya_boutiq/home_page.dart';

const users = const {
  'budiayu123@gmail.com': '123456',
  'emi123@gmail.com': 'emi123',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      //title: 'Sistem PKK',
      logo: AssetImage('assets/pkk_logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: (String name) async {
        String? result = await _recoverPassword(name);
        if (result != null) {
          // Handle the error here, for example, show a snackbar or toast message.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return null;
      },
    );
  }
}
