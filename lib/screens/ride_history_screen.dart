import 'package:flutter/material.dart';

class RideHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> rides = [
    {"date": "2025-08-01", "from": "کابل", "to": "مزار شریف"},
    {"date": "2025-08-05", "from": "هرات", "to": "قندهار"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تاریخچه سفرها"),
      ),
      body: ListView.builder(
        itemCount: rides.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.local_taxi),
              title: Text("${rides[index]['from']} → ${rides[index]['to']}"),
              subtitle: Text("تاریخ: ${rides[index]['date']}"),
            ),
          );
        },
      ),
    );
  }
}