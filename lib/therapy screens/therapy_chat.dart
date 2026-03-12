import 'package:flutter/material.dart';

class TherapyChat extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'David H. Brown', 'role': 'Psychologists'},
    {'name': 'Robert Johnson', 'role': 'Therapist'},
    {'name': 'Laura White', 'role': 'Psychologists'},
    {'name': 'Jennifer Miller', 'role': 'Psychologists'},
    {'name': 'Brian Clark', 'role': 'Psychologists'},
    {'name': 'Jaden John', 'role': 'Therapist'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFF3F6),
        title: Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
          child: Text('Chat'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            title: Text(
              contacts[index]['name']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(contacts[index]['role']!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/phone.png",
                  width: 24, height: 24,),
                SizedBox(width: 10),
                Image.asset("assets/images/video.png",
                  width: 24, height: 24,),
              ],
            ),
          );
        },
      ),
    );
  }
}
