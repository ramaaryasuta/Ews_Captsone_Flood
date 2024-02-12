import 'package:ews_capstone/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
    super.key,
    required this.userCtrl,
    required this.passCtrl,
    required this.listAdmin,
  });

  final TextEditingController userCtrl;
  final TextEditingController passCtrl;
  final List<AdminModel> listAdmin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset('assets/svg/login.svg'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: userCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Color(0xff34334A),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Kata sandi',
                      filled: true,
                      fillColor: Color(0xff34334A),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => login(userCtrl.text, passCtrl.text, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff34334A),
              ),
              child: Text(
                'Masuk',
                style: TextStyle(color: Colors.blueAccent.shade200),
              ),
            ),
          )
        ],
      ),
    );
  }

  void login(String username, String password, BuildContext context) {
    const failedLoginSnackBar = SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(
        'Username atau password salah',
        style: TextStyle(color: Colors.white),
      ),
    );

    const succesLoginSnackbar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        'Berhasil Masuk',
        style: TextStyle(color: Colors.white),
      ),
    );

    password = caesarCipher(password);
    if (listAdmin
        .where((element) =>
            element.username == username && element.password == password)
        .isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(succesLoginSnackbar);
      Navigator.pushNamedAndRemoveUntil(context, '/admin', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(failedLoginSnackBar);
    }
  }

  /// Encrypt for password
  String caesarCipher(String text) {
    String result = '';

    for (int i = 0; i < text.length; i++) {
      int charCode = text.codeUnitAt(i);
      if (charCode >= 65 && charCode <= 90) {
        result += String.fromCharCode((charCode - 65 + 3) % 26 + 65);
      } else if (charCode >= 97 && charCode <= 122) {
        result += String.fromCharCode((charCode - 97 + 3) % 26 + 97);
      } else {
        result += text[i];
      }
    }
    return result;
  }
}
