import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart'; // وارد کردن فایل رنگ‌های سفیر
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
        SnackBar(
          content: Text(result, style: const TextStyle(fontFamily: 'IranYekan')),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // نمایش لوگوی جدید سفیر
                Image.asset(
                  'assets/images/logo.png',
                  height: 120,
                ),
                const SizedBox(height: 30),
                const Text(
                  "ثبت‌نام در سفیر",
                  style: TextStyle(
                    fontFamily: 'IranYekan',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: SafirColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "سفری هوشمند و مطمئن را آغاز کنید",
                  style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // فیلد نام و تخلص
                      TextFormField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: 'نام و تخلص',
                          prefixIcon: const Icon(Icons.person_outline, color: SafirColors.primaryGreen),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        validator: (value) => (value == null || value.isEmpty) ? 'لطفا نام خود را وارد کنید' : null,
                        onSaved: (value) => _name = value!.trim(),
                      ),
                      const SizedBox(height: 15),
                      // فیلد ایمیل
                      TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          labelText: 'ایمیل',
                          hintText: 'example@mail.com',
                          prefixIcon: const Icon(Icons.email_outlined, color: SafirColors.primaryGreen),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => (value == null || value.isEmpty) ? 'لطفا ایمیل را وارد کنید' : null,
                        onSaved: (value) => _email = value!.trim(),
                      ),
                      const SizedBox(height: 15),
                      // فیلد رمز عبور
                      TextFormField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          labelText: 'رمز عبور',
                          prefixIcon: const Icon(Icons.lock_outline, color: SafirColors.primaryGreen),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        obscureText: true,
                        validator: (value) => (value == null || value.length < 6) ? 'رمز عبور باید حداقل ۶ حرف باشد' : null,
                        onSaved: (value) => _password = value!.trim(),
                      ),
                      const SizedBox(height: 30),
                      // دکمه ثبت‌نام با لودینگ
                      _isLoading
                          ? const CircularProgressIndicator(color: SafirColors.primaryGreen)
                          : ElevatedButton(
                              onPressed: () => _register(context),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 55),
                                backgroundColor: SafirColors.primaryGreen,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                              child: const Text(
                                'ثبت‌نام',
                                style: TextStyle(fontFamily: 'IranYekan', fontSize: 18, color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "حساب دارید؟ وارد شوید",
                    style: TextStyle(fontFamily: 'IranYekan', color: Colors.grey),
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
