import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';
  bool _isLoading = false;

  void _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);
    final result = await authService.registerWithEmail(_email, _password, _name);

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
                  "ثبت‌نام کاربر جدید",
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
                          labelText: 'نام و تخلص',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا نام خود را وارد کنید';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!.trim();
                        },
                      ),
                      const SizedBox(height: 15),
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
                          if (value == null || value.length < 6) {
                            return 'رمز عبور باید حداقل ۶ حرف باشد';
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
                              onPressed: () => _register(context),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'ثبت‌نام',
                                style: TextStyle(fontFamily: 'B_Nazanin'),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "حساب دارید؟ وارد شوید",
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