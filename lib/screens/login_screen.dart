import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);
    final result = await authService.loginWithEmail(_email, _password);

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                const Text(
                  "ورود به حساب کاربری",
                  style: TextStyle(
                    fontFamily: 'B_Nazanin',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ایمیل',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا ایمیل را وارد کنید';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!.trim();
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'رمز عبور',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا رمز عبور را وارد کنید';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!.trim();
                        },
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () => _login(context),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'ورود',
                                style: TextStyle(fontFamily: 'B_Nazanin'),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    "ثبت‌نام نکرده‌اید؟ اینجا کلیک کنید",
                    style: TextStyle(fontFamily: 'B_Nazanin'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}