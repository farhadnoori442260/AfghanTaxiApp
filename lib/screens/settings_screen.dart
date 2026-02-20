import 'package:flutter/material.dart';
import '../utils/helper.dart';
import '../utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'settings'))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            tr(context, 'language_settings'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _langTile(context, "دری", "fa"),
          _langTile(context, "پښتو", "ps"),
          _langTile(context, "English", "en"),
          const Divider(height: 40),
          ListTile(
            leading: const Icon(Icons.support_agent, color: SafirColors.primaryGreen),
            title: Text(tr(context, 'support')),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: Text(tr(context, 'exit')),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _langTile(BuildContext context, String name, String code) {
    bool isCurrent = Localizations.localeOf(context).languageCode == code;
    return ListTile(
      title: Text(name),
      trailing: isCurrent ? const Icon(Icons.check_circle, color: SafirColors.primaryGreen) : null,
      onTap: () {
        // اینجا بعداً منطق تغییر زبان سیستم را وصل می‌کنیم
      },
    );
  }
}
